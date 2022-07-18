import 'dart:async';
import 'dart:developer';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twilio/flutter_twilio.dart';
import 'package:flutter_twilio/model/call.dart';
import 'package:flutter_twilio/model/event.dart';
import 'package:flutter_twilio/model/status.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/message_call_participant.dart';
import 'package:truvideo_enterprise/model/message_member.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/voip/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/active_call/active_call.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';

import 'buttons.dart';
import 'disconnected_call.dart';

class ScreenActiveCallParams {
  final List<MessageMemberModel>? callToMembers;
  final String? channelUID;

  ScreenActiveCallParams({
    this.callToMembers,
    this.channelUID,
  });
}

class ScreenActiveCall extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenActiveCall";

  const ScreenActiveCall({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenActiveCall> createState() => _ScreenActiveCallState();
}

class _ScreenActiveCallState extends ConsumerState<ScreenActiveCall> {
  ScreenActiveCallParams? _params;
  FlutterTwilioCall? _call;
  Timer? _stopWatchTimer;

  bool _callDisconnected = false;
  bool _changingMute = false;
  bool _changingSpeaker = false;
  bool _closing = false;
  bool _callConnected = false;

  Timer? _participantsTimer;
  var _participants = <MessageCallParticipantModel>[];

  Duration get _fetchParticipantsDelay => const Duration(seconds: 2);

  StreamSubscription? _callsEventSubscription;
  StreamSubscription<ProximityEvent>? _proximitySensorSubscription;

  @override
  void initState() {
    super.initState();
    _initProximitySensor();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _stopListenParticipants();
    _stopWatchTimer?.cancel();
    _proximitySensorSubscription?.cancel();
    _callsEventSubscription?.cancel();
    super.dispose();
  }

  _init() async {
    if (_params == null) {
      Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
      return;
    }

    _callsEventSubscription?.cancel();
    _callsEventSubscription = FlutterTwilio.onCallEvent.listen(_onCallEvent);

    // Make call
    if (_params!.callToMembers != null) {
      _makeCall();
      return;
    }

    _stopWatchTimer?.cancel();
    _stopWatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {});
    });

    final call = await FlutterTwilio.getActiveCall();

    if (call != null) {
      _onCallEvent(FlutterTwilioEvent(call.status, call));
    } else {
      log("No active call");
      _close();
    }
  }

  _onCallEvent(FlutterTwilioEvent event) {
    if (!mounted) return;

    final callId = event.call?.id ?? "";
    final callDisconnected = event.call == null || event.status == FlutterTwilioStatus.disconnected;

    setState(() {
      if (callId.isNotEmpty) {
        _callConnected = true;
      }
      _callDisconnected = callDisconnected;
      _call = event.call;
      if (callDisconnected) _call = null;
    });

    if (callId.trim().isNotEmpty && !callDisconnected) {
      _listenParticipants();
    } else {
      _stopListenParticipants();
    }

    _onStatusChanged(event.status);
  }

  _onStatusChanged(FlutterTwilioStatus status) {}

  _initProximitySensor() {
    _proximitySensorSubscription?.cancel();
    _proximitySensorSubscription = proximityEvents?.listen((ProximityEvent event) {
      if (event.getValue() == true && _call?.speaker == true) {
        _toggleSpeaker();
      }
    });
  }

  _makeCall() async {
    try {
      final user = ref.read(authPod);
      final members = _params?.callToMembers ?? <MessageMemberModel>[];
      if (members.isEmpty) {
        throw CustomException(message: "No members to call");
      }

      final AuthService authService = GetIt.I.get();

      final call = await FlutterTwilio.makeCall(
        to: members.map((e) => e.uid).join(","),
        data: {
          "fromDisplayName": user?.displayName ?? "Unknown name",
          "toDisplayName": members.length > 1 ? "Conference call" : members[0].displayName,
          "channelUID": _params?.channelUID ?? "",
          "accountUID": authService.accountUid ?? "",
        },
      );

      if (!mounted) return;

      _onCallEvent(FlutterTwilioEvent(call.status, call));
    } catch (error, stack) {
      log("Error making call", error: error, stackTrace: stack);
      if (!mounted) return;

      final retry = await showCustomDialogRetry(message: "$error");
      if (retry) {
        _makeCall();
      } else {
        _close();
      }
    }
  }

  _hangUp() async {
    if (_call == null && !_callConnected) {
      log("Cant close the screen yet. No call or call disconnected");
      return;
    }

    final callId = _call?.id.trim() ?? "";
    if ((_call != null && callId.isEmpty)) {
      log("Cant close the screen yet. Call Id emptu");
      return;
    }

    _close();
  }

  _close() async {
    if (_closing) return;
    _closing = true;

    _stopListenParticipants();
    _cleanUp();

    Navigator.of(context).pop();
  }

  _cleanUp() async {
    final pod = ref.read(voipCallStatusPod.notifier);
    pod.state = VoipCallStatus.loading;

    final VoipService voipService = GetIt.I.get();
    final accountUID = ref.read(messagingAuthenticationInformationPod)?.accountUID ?? "";
    var channelUID = _params?.channelUID ?? _call?.customParameters["channelUID"];

    try {
      await voipService.updateConferenceStatus(
        channelUID: channelUID,
        accountUID: accountUID,
      );
    } catch (error, stack) {
      log("Error updating conference status", error: error, stackTrace: stack);
    }

    try {
      await FlutterTwilio.hangUp();
    } catch (error, stack) {
      log("Error hanging up call", error: error, stackTrace: stack);
    }

    pod.state = VoipCallStatus.ready;
  }

  _toggleMic() async {
    try {
      setState(() => _changingMute = true);
      await FlutterTwilio.toggleMute();
      if (!mounted) return;
      setState(() => _changingMute = false);
      _getParticipants();
    } catch (error, stack) {
      log("Error toggling mic", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _changingMute = false);
    }
  }

  _toggleSpeaker() async {
    try {
      setState(() => _changingSpeaker = true);
      await FlutterTwilio.toggleSpeaker();
      if (!mounted) return;
      setState(() => _changingSpeaker = false);
    } catch (error, stack) {
      log("Error toggling speaker", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _changingSpeaker = false);
    }
  }

  String get _statusText {
    if (_call == null || _callDisconnected) return "";
    switch (_call!.status) {
      case FlutterTwilioStatus.connecting:
        return "Connecting";
      case FlutterTwilioStatus.disconnected:
        return "Disconnected";
      case FlutterTwilioStatus.ringing:
        return "Connecting";
      case FlutterTwilioStatus.connected:
        return "Connected";
      case FlutterTwilioStatus.reconnecting:
        return "Reconnecting";
      case FlutterTwilioStatus.reconnected:
        return "Connected";
      case FlutterTwilioStatus.unknown:
        return "Status unknown";
    }
  }

  bool _listeningParticipants = false;

  _listenParticipants() {
    if (_listeningParticipants) return;
    _listeningParticipants = true;

    log("Listening participants");

    _participantsTimer?.cancel();
    _participantsTimer = Timer.periodic(_fetchParticipantsDelay, (timer) {
      if (!mounted) return;
      _getParticipants();
    });
    _getParticipants();
  }

  _stopListenParticipants() {
    _listeningParticipants = false;
    _participantsTimer?.cancel();
    _participantsTimer = null;
    log("Stop listening participants");
  }

  _getParticipants() async {
    try {
      final VoipService voipService = GetIt.I.get();
      final accountUID = ref.read(messagingAuthenticationInformationPod)?.accountUID ?? "";

      var p = <MessageCallParticipantModel>[];
      var channelUID = _params?.channelUID ?? _call?.customParameters["channelUID"];
      if (channelUID != null) {
        p = await voipService.getParticipants(
          channelUID: channelUID,
          accountUID: accountUID,
        );
      }
      if (!mounted) return;

      setState(() {
        _participants = p;
      });
    } catch (error, stack) {
      log("Error getting participants", error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() {
        _participants = [];
      });
    }
  }

  _onParticipantPressed(MessageCallParticipantModel model) {}

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context)?.settings.arguments as ScreenActiveCallParams?;
    final messagingUser = ref.watch(messagingAuthenticationInformationPod);
    final backgroundColor = CustomColorsUtils.callBackground;

    return CustomScaffold(
      onWillPop: () async => false,
      appbar: const CustomAppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: Stack(
              children: [
                // Active
                Positioned.fill(
                  child: CustomAnimatedFadeVisibility(
                    visible: !_callDisconnected,
                    child: ActiveCall(
                      to: _call?.outgoing == true ? (_call?.toDisplayName ?? "") : (_call?.fromDisplayName ?? ""),
                      status: _statusText,
                      createdAt:
                          _participants.firstWhereOrNull((e) => e.messageableEntityUID == messagingUser?.subjectMessageableEntity?.uid)?.createdAt,
                      participants: _participants,
                      onParticipantPressed: _onParticipantPressed,
                    ),
                  ),
                ),

                // Inactive
                Positioned.fill(
                  child: CustomAnimatedFadeVisibility(
                    visible: _callDisconnected,
                    child: const DisconnectedCall(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0).copyWith(bottom: 32 + MediaQuery.of(context).viewPadding.bottom),
            child: CallButtons(
              micMuted: _call?.mute ?? false,
              micMutedEnabled: !_changingMute,
              onMicMutePressed: _toggleMic,
              micMuteVisible: !_callDisconnected,
              speaker: _call?.speaker ?? false,
              speakerEnabled: !_changingSpeaker,
              speakerVisible: !_callDisconnected,
              onSpeakerPressed: _toggleSpeaker,
              callDisconnected: _callDisconnected,
              onClosePressed: _hangUp,
            ),
          ),
        ],
      ),
    );
  }
}

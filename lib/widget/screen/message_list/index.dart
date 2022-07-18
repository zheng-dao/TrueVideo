import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/hook/chat_message_list.dart';
import 'package:truvideo_enterprise/main.dart';
import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_chat.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_status.dart';
import 'package:truvideo_enterprise/model/offline_enqueue/offline_enqueue_item_type.dart';
import 'package:truvideo_enterprise/riverpod/voip_call_status.dart';
import 'package:truvideo_enterprise/riverpod/debug.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/service/messaging/_interface.dart';
import 'package:truvideo_enterprise/service/offline_enqueue_service/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/snackbar/index.dart';
import 'package:truvideo_enterprise/widget/dialog/messaging/delete_messages/index.dart';
import 'package:truvideo_enterprise/widget/screen/active_call/index.dart';
import 'package:truvideo_enterprise/widget/screen/message_channel_info/index.dart';
import 'package:truvideo_enterprise/widget/screen/message_list/message_composer.dart';
import 'package:truvideo_enterprise/widget/screen/splash/index.dart';

import 'list_item.dart';
import 'model/message_list_item_model.dart';
import 'shimmer_list.dart';

class ScreenMessageListParams {
  final String memberUID;
  final String channelUID;

  final String initialTitle;

  ScreenMessageListParams({
    required this.memberUID,
    required this.channelUID,
    this.initialTitle = "",
  });
}

class ScreenMessageList extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenMessageList";

  const ScreenMessageList({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenMessageList> createState() => _ScreenMessageListState();
}

class _ScreenMessageListState extends ConsumerState<ScreenMessageList> {
  ScreenMessageListParams? _params;
  final _textController = TextEditingController();

  StreamSubscription? _channelStreamSubscription;
  MessageChannelModel? _channel;

  bool _loading = true;
  var _onlineItems = <MessageModel>[];
  dynamic _error;
  bool _inited = false;

  var _items = <MessageListItemModel>[];

  bool _selecting = false;
  var _selectedUuids = <String>[];

  Timer? _timerPolling;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _timerPolling?.cancel();
    _channelStreamSubscription?.cancel();
    _textController.dispose();
    super.dispose();
  }

  _init() async {
    if (_params == null) {
      _goToSplash();
      return;
    }

    _timerPolling = Timer.periodic(const Duration(seconds: 10), (timer) {
      _refreshData(loading: false);
    });

    final MessagingService messageService = GetIt.I.get();
    final cached = await messageService.getCachedMessages(memberUID: _params!.memberUID);
    if (cached.isNotEmpty) {
      log("With cached items");

      setState(() {
        _onlineItems = cached;
        _loading = false;
        _error = null;
      });
    }

    setState(() => _inited = true);
    _refreshChannel();
    _refreshData(loading: cached.isEmpty);
  }

  _refreshChannel() async {
    final MessagingService messageService = GetIt.I.get();

    _channelStreamSubscription?.cancel();
    _channelStreamSubscription = messageService.streamChannelByUid(_params!.channelUID).listen(
      (event) {
        if (!mounted) return;

        setState(() {
          _channel = event;
        });
      },
      cancelOnError: true,
    )..onError((error) {
        if (!mounted) return;
        setState(() {
          _channel = null;
        });
      });
  }

  _goToSplash() {
    Navigator.of(context).pushReplacementNamed(ScreenSplash.routeName);
  }

  _refreshData({bool loading = true}) async {
    try {
      setState(() {
        _loading = loading;
        _error = null;
      });

      final MessagingService service = GetIt.I.get();
      final messagingAuthenticationInformation = ref.read(messagingAuthenticationInformationPod);
      final newItems = await service.getMessages(
        memberUID: _params!.memberUID,
        accountUID: messagingAuthenticationInformation?.accountUID ?? "",
      );

      if (!mounted) return;

      setState(() {
        _onlineItems = newItems;
        _loading = false;
        _error = null;
      });
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  _close() {
    Navigator.of(context).pop();
  }

  _sendMessage(String value) async {
    if (value.trim().isEmpty) {
      return;
    }

    final messagingAuthenticationInformation = ref.read(messagingAuthenticationInformationPod);
    final accountUID = messagingAuthenticationInformation?.accountUID ?? "";
    final auxUID =
        "${_params!.memberUID}_${messagingAuthenticationInformation?.subjectMessageableEntity?.uid}_${DateTime.now().millisecondsSinceEpoch}";

    final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
    offlineEnqueueService.enqueue(
      OfflineEnqueueItemModel(
        typeIndex: OfflineEnqueueItemType.chat.index,
        data: OfflineEnqueueItemChatModel(
          accountUID: accountUID,
          channelUID: _params?.channelUID ?? "",
          text: value,
          auxUID: auxUID,
        ).toJson(),
      ),
    );

    _textController.text = "";
  }

  _onMessagePressed(MessageListItemModel model) {
    if (model.isFromOfflineEnqueue && model.offlineEnqueueStatus != OfflineEnqueueItemStatus.done) {
      if (_selecting) return;

      if (model.offlineEnqueueStatus == OfflineEnqueueItemStatus.error) {
        _showRetrySend(model.offlineEnqueueUid);
      }
      return;
    }

    if (_selecting) {
      if (_selectedUuids.any((e) => e == model.model!.uid)) {
        _selectedUuids = _selectedUuids.where((e) => e != model.model!.uid).toList();
      } else {
        _selectedUuids = [..._selectedUuids, model.model!.uid];
      }
      _selecting = _selectedUuids.isNotEmpty;
      setState(() {});
      return;
    }
  }

  _onMessageLongPressed(MessageListItemModel model) {
    if (model.isFromOfflineEnqueue && model.offlineEnqueueStatus != OfflineEnqueueItemStatus.done) {
      return;
    }

    List<String> newSelectedUIDs;
    if (_selectedUuids.any((e) => e == model.model!.uid)) {
      newSelectedUIDs = _selectedUuids.where((e) => e != model.model!.uid).toList();
    } else {
      newSelectedUIDs = [..._selectedUuids, model.model!.uid];
    }

    setState(() {
      _selectedUuids = newSelectedUIDs;
      _selecting = _selectedUuids.isNotEmpty;
    });
  }

  _onButtonMessageInfoPressed() async {
    // if (_selectedUuids.isEmpty) return;
    // var items = _items.where((e) => e.model!.uid == _selectedUuids[0]).toList();
    // if (items.isEmpty) {
    //   return;
    // }
    // final model = items[0];
    //
    // showCustomDialog(
    //   title: "Message data",
    //   builder: (context, controller) {
    //     return JsonViewer(model.toJson());
    //   },
    //   buttonsBuilder: (context, controller) => [
    //     CustomBorderButton(
    //       text: "Accept",
    //       onPressed: () {
    //         controller.close();
    //       },
    //     ),
    //   ],
    // );
  }

  _cancelSelection() {
    setState(() {
      _selectedUuids = [];
      _selecting = false;
    });
  }

  Future<bool> _onWillPop() async {
    if (_selecting) {
      _cancelSelection();
      return false;
    }

    return true;
  }

  _onButtonDeleteSelectionPressed() async {
    if (_selectedUuids.isEmpty) {
      _cancelSelection();
      return;
    }

    final deleted = await showCustomMessagesDelete(_selectedUuids);
    if (deleted) {
      _onlineItems = _onlineItems.where((e) => !_selectedUuids.contains(e.uid)).toList();
      _cancelSelection();
    }
  }

  _showRetrySend(String uid) {
    showCustomDialog(
      title: "Error sending the message",
      buttonsBuilder: (context, controller) => [
        CustomBorderButton.small(
          text: "Cancel",
          onPressed: () {
            controller.close();
          },
        ),
        CustomBorderButton.small(
          text: "Delete",
          borderColor: Colors.red.shade600,
          textColor: Colors.red.shade600,
          onPressed: () {
            controller.close();

            final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
            offlineEnqueueService.delete(uid);
          },
        ),
        CustomGradientButton.small(
          gradient: CustomColorsUtils.gradient,
          text: "Retry",
          onPressed: () {
            controller.close();

            final OfflineEnqueueService offlineEnqueueService = GetIt.I.get();
            offlineEnqueueService.retry(uid);
          },
        ),
      ],
    );
  }

  _call() {
    CustomKeyboardUtils.hide();

    final messageableUID = ref.read(messagingAuthenticationInformationPod)?.subjectMessageableEntity?.uid ?? "";
    final accountUID = ref.read(messagingAuthenticationInformationPod)?.subAccountMessageableEntity?.uid ?? "";
    if (messageableUID.trim().isEmpty && accountUID.trim().isEmpty) return;

    final me = (_channel?.members ?? []).firstWhereOrNull((e) => (e.uid == messageableUID || e.uid == accountUID));
    if (me == null) {
      showCustomSnackBarError(title: "Something went wrong");
      return;
    }

    final members = (_channel?.members ?? []).where((e) => e.uid != me.uid).toList();
    if (members.isEmpty) {
      showCustomSnackBarError(title: "There is no members to call");
      return;
    }

    Navigator.of(context).pushNamed(
      ScreenActiveCall.routeName,
      arguments: ScreenActiveCallParams(
        callToMembers: members,
        channelUID: _params?.channelUID ?? "",
      ),
    );
  }

  String get _title {
    if (_channel == null) return _params?.initialTitle ?? "";
    final auth = ref.read(messagingAuthenticationInformationPod);
    return _channel!.getName(
      accountUID: auth?.subAccountMessageableEntity?.uid ?? "",
      subjectUID: auth?.subjectMessageableEntity?.uid ?? "",
    );
  }

  _onHeaderPressed() {
    if (_channel == null) return;

    Navigator.of(context).pushNamed(
      ScreenMessageChannelInfo.routeName,
      arguments: ScreenMessageChannelInfoParams(
        model: _channel!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context)?.settings.arguments as ScreenMessageListParams?;

    final debug = ref.watch(debugPod);
    final callStatus = ref.watch(voipCallStatusPod);
    final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
    final canSwipeBack = !_selecting;

    _items = useChatMessageList(
      ref,
      channelUID: _params?.channelUID ?? "",
      messages: _onlineItems,
      channel: _channel,
    );

    return CustomScaffold(
      onWillPop: canSwipeBack ? null : _onWillPop,
      backgroundColor: CustomColorsUtils.chatBackground,
      appbar: CustomAppBar(
        title: _title,
        onPressed: (_channel == null || _channel!.type == "DIRECT_MESSAGE") ? null : _onHeaderPressed,
        leading: CustomButtonIcon(
          icon: Icons.arrow_back_ios,
          onPressed: _close,
          backgroundColor: Colors.transparent,
          iconColor: appBarIconColor,
        ),
        actionButtons: [
          CustomButtonIcon(
            enabled: _channel != null && callStatus == VoipCallStatus.ready,
            icon: Icons.call_outlined,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
            tooltip: "Call",
            onPressed: _call,
          ),
        ],
        overlay: CustomAnimatedFadeVisibility(
          visible: _selecting,
          child: CustomAppBar(
            leading: CustomButtonIcon(
              icon: Icons.clear,
              tooltip: "Close",
              onPressed: _cancelSelection,
              backgroundColor: Colors.transparent,
              iconColor: appBarIconColor,
            ),
            statusBar: false,
            title: "${_selectedUuids.length}",
            actionButtons: [
              if (debug && _selecting && _selectedUuids.length == 1)
                CustomButtonIcon(
                  key: const ValueKey("message-info"),
                  icon: Icons.info_outline,
                  tooltip: "Message ingo",
                  backgroundColor: Colors.transparent,
                  iconColor: appBarIconColor,
                  onPressed: _onButtonMessageInfoPressed,
                ),
              CustomButtonIcon(
                key: const ValueKey("delete"),
                icon: Icons.delete_outline,
                tooltip: "Delete",
                backgroundColor: Colors.transparent,
                iconColor: appBarIconColor,
                onPressed: _onButtonDeleteSelectionPressed,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          CustomAnimatedCollapseVisibility(
            visible: callStatus == VoipCallStatus.error,
            child: CustomListTile(
              titleText: "Error setting up the Voip Calls",
              dense: true,
              color: Colors.orange,
              trailing: CustomBorderButton.small(
                text: "Retry",
                textColor: Colors.white,
                borderColor: Colors.white,
                highlightColor: Colors.white.withOpacity(0.2),
                splashColor: Colors.white.withOpacity(0.2),
                onPressed: () => appKey.currentState?.registerVoipCalls(),
              ),
            ),
          ),
          Expanded(
            child: CustomFadingEdgeList(
              color: CustomColorsUtils.chatBackground,
              child: RefreshIndicator(
                onRefresh: () async {
                  _refreshData();
                },
                child: CustomList<MessageListItemModel>(
                  areItemsTheSame: (a, b) => a.model?.uid == b.model?.uid,
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  reverse: true,
                  loading: _loading,
                  error: _error,
                  data: _items,
                  loadingBuilder: (c) => _inited ? const ScreenMessageListShimmerList() : Container(),
                  itemBuilder: (context, item) => MessageListItem(
                    key: ValueKey("${item.model?.uid}_${item.offlineEnqueueUid}"),
                    model: item,
                    channel: _channel,
                    onPressed: _onMessagePressed,
                    onLongPressed: _onMessageLongPressed,
                    selected: _selectedUuids.contains(item.model?.uid ?? ""),
                  ),
                  errorBuilder: (BuildContext context, error) => CustomListIndicatorError(
                    onButtonPressed: () => _refreshData(),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[2],
              color: Colors.white,
            ),
            child: CustomMessageComposer(
              autoFocus: true,
              enabled: !_selecting,
              onButtonSendPressed: _sendMessage,
              controller: _textController,
            ),
          ),
        ],
      ),
    );
  }
}

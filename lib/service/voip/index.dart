import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/model/message_call_participant.dart';
import 'package:truvideo_enterprise/model/voip_call_token.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/device/index.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/voip/_interface.dart';

class VoipServiceImpl extends VoipService {
  final String baseURL;
  final PlatformInfo _platformInfo;

  VoipServiceImpl({PlatformInfo? platformInfo,
    required this.baseURL,
  }) : _platformInfo = platformInfo ?? PlatformInfo();

  @override
  Future<VoipCallTokenModel?> register({
    required String uid,
    required String accountUID,
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;

    String deviceType = "";
    if (!_platformInfo.isWeb) {
      if (_platformInfo.isAndroid) {
        deviceType = "Android";
      }

      if (_platformInfo.isIOS) {
        deviceType = "Iphone";
      }
    }

    final result = await httpService.post(
      Uri.parse("$baseURL/api/voip/token"),
      data: {
        "accountUID": accountUID,
        "messageableEntityUID": uid,
        "deviceType": deviceType,
      },
      headers: {
        "x-authorization-truvideo": token,
      },
    );

    try {
      return VoipCallTokenModel.fromJson(result.data as Map<String, dynamic>);
    } catch (error, stack) {
      log("Error parsing twilio token", error: error, stackTrace: stack);
      return null;
    }
  }

  @override
  Future<List<MessageCallParticipantModel>> getParticipants({
    required String channelUID,
    required String accountUID,
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;

    final result = await httpService.post(
      Uri.parse("$baseURL/api/voip/getConferenceParticipants"),
      data: {
        "accountUID": accountUID,
        "channelUID": channelUID,
      },
      headers: {
        "x-authorization-truvideo": token,
        "channelUID": channelUID,
      },
    );

    return (result.data! as List<dynamic>)
        .map((e) {
          try {
            return MessageCallParticipantModel.fromJson(e as Map<String, dynamic>);
          } catch (error, stack) {
            log("Error parsing MessageCallParticipantModel", error: error, stackTrace: stack);
            return null;
          }
        })
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  @override
  Future<void> muteParticipant({
    required String channelUID,
    required String accountUID,
    required String participantCallSID,
    required bool muted,
  }) async {
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;

    await httpService.post(
      Uri.parse("$baseURL/api/voip/updateConferenceParticipant"),
      data: {
        "accountUID": accountUID,
        "channelUID": channelUID,
        "participantCallSID": participantCallSID,
        "muted": muted,
      },
      headers: {
        "x-authorization-truvideo": token,
        "channelUID": channelUID,
      },
    );
  }

  @override
  Future<void> updateConferenceStatus({required String channelUID, required String accountUID}) async {
    await Future.delayed(const Duration(seconds: 1));
    final HttpService httpService = GetIt.I.get();
    final AuthService service = GetIt.I.get();
    final token = service.token;

    await httpService.post(
      Uri.parse("$baseURL/updateConferenceStatus"),
      data: {
        "accountUID": accountUID,
        "channelUID": channelUID,
      },
      headers: {
        "x-authorization-truvideo": token,
        "channelUID": channelUID,
      },
    );
  }
}

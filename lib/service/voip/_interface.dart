import 'package:truvideo_enterprise/model/message_call_participant.dart';
import 'package:truvideo_enterprise/model/voip_call_token.dart';

abstract class VoipService {
  Future<VoipCallTokenModel?> register({
    required String uid,
    required String accountUID,
  });

  Future<List<MessageCallParticipantModel>> getParticipants({
    required String channelUID,
    required String accountUID,
  });

  Future<void> muteParticipant({
    required String channelUID,
    required String accountUID,
    required String participantCallSID,
    required bool muted,
  });

  Future<void> updateConferenceStatus({
    required String channelUID,
    required String accountUID,
  });
}

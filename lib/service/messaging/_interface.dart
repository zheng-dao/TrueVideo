import 'package:truvideo_enterprise/model/message.dart';
import 'package:truvideo_enterprise/model/message_authentication_information.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/message_member.dart';

abstract class MessagingService {
  Future<MessageAuthenticationInformationModel?> getCachedAuthenticationInformation();

  Future<MessageAuthenticationInformationModel?> authenticate();

  Future<List<MessageMemberModel>> getMembersPaginated({
    required String accountUID,
    bool onlyReplied = false,
    int pageLength = 10,
    int page = 0,
  });

  Future<List<MessageMemberModel>> getCachedMembers();

  Future<MessageChannelModel?> getChannelByUid(String uid);

  Stream<MessageChannelModel?> streamChannelByUid(String uid);

  Future<List<MessageModel>> getCachedMessages({required String memberUID});

  Future<List<MessageModel>> getMessages({
    required String accountUID,
    required String memberUID,
  });

  Future<void> deleteChannels(List<String> uuids);

  Future<void> markAsArchived(List<String> uuids, bool archived);

  Future<void> markAsFavorite(List<String> uuids, bool favorite);

  Future<MessageModel> createMessage({
    required String channelUID,
    required String message,
    required String accountUID,
    String auxUID = "",
  });

  Future<void> deleteMessages(List<String> uuids);
}

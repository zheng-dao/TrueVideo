import 'package:truvideo_enterprise/model/support_info.dart';

abstract class SupportService {
  Future<SupportInfoModel> getInfo();

  Future<void> sendInfo({required SupportInfoModel? supportInfo, String? email, String? phone, String? comment});
  Future<void> autoSendInfo({Function(String)? onProgressChange});
}

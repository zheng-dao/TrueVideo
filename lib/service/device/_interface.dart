import 'package:truvideo_enterprise/model/device_info.dart';

abstract class DeviceService {
  Future<DeviceInfoModel> getInfo();

  Future<String> getBatteryLevel();

  Future<String> getPackageVersion();
  Future<String> getPackageBuildNumber();

}

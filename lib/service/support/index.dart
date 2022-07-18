import 'dart:developer';
import 'dart:io';

import 'package:disk_space/disk_space.dart';
import 'package:filesize/filesize.dart';
import 'package:get_it/get_it.dart';
import 'package:ios_physical_memory/ios_physical_memory.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:system_info2/system_info2.dart';
import 'package:external_storage_size/external_storage_size.dart';
import 'package:truvideo_enterprise/core/permission.dart';
import 'package:truvideo_enterprise/model/support_info.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/service/device/_interface.dart';
import 'package:truvideo_enterprise/service/http/_interface.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/service/support/_interface.dart';
import 'package:path_provider/path_provider.dart';

///{@template app_package_info}
/// Model representing the package info.
///
///{@endtemplate}
class AppPackageInfo {
  /// {@macro app_package_info}
  const AppPackageInfo();

//#region Instance methods

  Future<PackageInfo> fromPlatform() async {
    return PackageInfo.fromPlatform();
  }

//#endregion
}

class SupportServiceImpl extends SupportService {
  AuthService get _authService => GetIt.I.get();

  DeviceService get _deviceService => GetIt.I.get();

  ConnectivityService get _connectivityService => GetIt.I.get();

  HttpService get _httpService => GetIt.I.get();

  final AppPackageInfo appPackageInfo;
  final String baseURL;
  final String supportBaseURL;

  SupportServiceImpl({
    this.appPackageInfo = const AppPackageInfo(),
    required this.baseURL,
    required this.supportBaseURL,
  });

  @override
  Future<SupportInfoModel> getInfo() async {
    final device = await _deviceService.getInfo();
    final user = await _authService.getMyProfile();
    final packageInfo = await appPackageInfo.fromPlatform();
    final DateService dateService = GetIt.I.get();

    final wifiInternetSettings = await checkWifiInternetSettings();
    final truVideoServer = await checkTruVideoServer();
    var freeDiskSpace = await checkDiskSpaceAvailable();
    final videoStored = await checkVideoSize();
    final microphoneAccess = await CustomPermissionUtils.check([Permission.microphone]) ? "Yes" : "No";
    final notificationAccess = await CustomPermissionUtils.check([Permission.notification]) ? "Yes" : "No";
    final networkType = await _connectivityService.networkType();
    final recordingSettings = await checkRecordingSettings();
    final batteryLevel = await _deviceService.getBatteryLevel();
    final freeMemory = Platform.isAndroid ? filesize(SysInfo.getFreeVirtualMemory()) : await IosPhysicalMemory.availableFreeMemory ?? '-';
    final totalPhysicalMemory = Platform.isAndroid ? filesize(SysInfo.getTotalPhysicalMemory()) : await IosPhysicalMemory.physicalMemory ?? '-';
    final availableExternalStorage = Platform.isAndroid ? await ExternalStorageSize.externalStorageSize : '-';

    return SupportInfoModel(
      phoneId: device.id,
      phoneType: "${device.model} (${device.manufacturer})",
      dealerName: (user?.dealer?.name ?? ""),
      dealerUuid: (_authService.accountUid ?? ""),
      userId: (_authService.sub ?? ""),
      appVersion: "${packageInfo.version} (${packageInfo.buildNumber})",
      dateTime: dateService.formatDateTime(DateTime.now()),
      phoneOS: device.phoneOS,
      wifiInternetSettings: wifiInternetSettings,
      truVideoServer: truVideoServer,
      freeDiskSpace: freeDiskSpace,
      videoStored: videoStored,
      microphoneAccess: microphoneAccess,
      notificationAccess: notificationAccess,
      networkType: networkType,
      recordingSettings: recordingSettings,
      videoFormat: 'H.264 MPEG-4',
      batteryLevel: batteryLevel,
      freeVirtualMemory: freeMemory,
      totalPhysicalMemory: totalPhysicalMemory,
      freeExternalStorage: availableExternalStorage ?? '-',
    );
  }

  @override
  Future<void> sendInfo({required SupportInfoModel? supportInfo, String? email, String? phone, String? comment}) async {
    final token = await _authService.token;
    final accountUID = _authService.accountUid;

    await _httpService.post(
      Uri.parse("$supportBaseURL/api/v3/support?account-uid=$accountUID"),
      data: {
        "appVersion": supportInfo?.appVersion,
        "dateTime": supportInfo?.dateTime,
        "phoneId": supportInfo?.phoneId,
        "phoneType": supportInfo?.phoneType,
        "phoneOsVersion": supportInfo?.phoneOS,
        "wifiInternetSettings": supportInfo?.wifiInternetSettings,
        "truVideoServer": supportInfo?.truVideoServer,
        "memoryFree": supportInfo?.freeVirtualMemory,
        "memoryTotal": supportInfo?.totalPhysicalMemory,
        "storageFree": supportInfo?.freeDiskSpace,
        "videoStored": supportInfo?.videoStored,
        "oldVideosStored": "-",
        "locationServices": "-",
        "location": "-",
        "accessToMicrophone": supportInfo?.microphoneAccess,
        "notifications": supportInfo?.notificationAccess,
        "googlePlayAccount": "-",
        "networkType": supportInfo?.networkType,
        "networkTest": "-",
        "bandwidthTest": supportInfo?.bandwidthTest ?? '',
        "videoSettings": supportInfo?.recordingSettings,
        "comment": comment,
        "email": email,
        "phoneNumber": phone,
        "storageCleanupSchedule": "-",
        "battery": supportInfo?.batteryLevel,
        "videoFormat": supportInfo?.videoFormat,
      },
      headers: {
        "x-authorization-truvideo": token,
      },
    );
  }

  @override
  Future<void> autoSendInfo({Function(String)? onProgressChange}) async {
    double bandwidthTest = 0;

    final ConnectivityService connectivityService = GetIt.I.get();
    try {
      if (onProgressChange != null) onProgressChange("Running Bandwith test...");
      bandwidthTest = await connectivityService.runBandwidthTest(callback: ((speed, percentage) {
        if (onProgressChange != null) {
          onProgressChange(
            "Performing Bandwith test (${(percentage * 100).toStringAsFixed(2)}%)...",
          );
        }
      }));
    } catch (e) {
      throw Exception("BandWith test failed.");
    }
    final device = await _deviceService.getInfo();
    final user = await _authService.getMyProfile();
    final packageInfo = await appPackageInfo.fromPlatform();
    final DateService dateService = GetIt.I.get();

    final wifiInternetSettings = await checkWifiInternetSettings();
    final truVideoServer = await checkTruVideoServer();
    var freeDiskSpace = await checkDiskSpaceAvailable();
    final videoStored = await checkVideoSize();
    final microphoneAccess = await CustomPermissionUtils.check([Permission.microphone]) ? "Yes" : "No";
    final notificationAccess = await CustomPermissionUtils.check([Permission.notification]) ? "Yes" : "No";
    final networkType = await connectivityService.networkType();
    final recordingSettings = await checkRecordingSettings();
    final batteryLevel = await _deviceService.getBatteryLevel();
    final freeMemory = Platform.isAndroid ? filesize(SysInfo.getFreeVirtualMemory()) : await IosPhysicalMemory.availableFreeMemory ?? '-';
    final totalPhysicalMemory = Platform.isAndroid ? filesize(SysInfo.getTotalPhysicalMemory()) : await IosPhysicalMemory.physicalMemory ?? '-';
    final availableExternalStorage = Platform.isAndroid ? await ExternalStorageSize.externalStorageSize : '-';
    if (onProgressChange != null) onProgressChange("Fetching device local info...");
    SupportInfoModel model = SupportInfoModel(
      phoneId: device.id,
      phoneType: "${device.model} (${device.manufacturer})",
      dealerName: (user?.dealer?.name ?? ""),
      dealerUuid: (_authService.accountUid ?? ""),
      userId: (_authService.sub ?? ""),
      appVersion: "${packageInfo.version} (${packageInfo.buildNumber})",
      dateTime: dateService.formatDateTime(DateTime.now()),
      phoneOS: device.phoneOS,
      wifiInternetSettings: wifiInternetSettings,
      truVideoServer: truVideoServer,
      freeDiskSpace: freeDiskSpace,
      videoStored: videoStored,
      microphoneAccess: microphoneAccess,
      notificationAccess: notificationAccess,
      networkType: networkType,
      recordingSettings: recordingSettings,
      videoFormat: 'H.264 MPEG-4',
      batteryLevel: batteryLevel,
      freeVirtualMemory: freeMemory,
      totalPhysicalMemory: totalPhysicalMemory,
      freeExternalStorage: availableExternalStorage ?? '-',
      bandwidthTest: "${bandwidthTest.toStringAsFixed(2)} MB/s",
    );

    final token = await _authService.token;
    final accountUID = _authService.accountUid;
    if (onProgressChange != null) onProgressChange("Sending info...");

    await _httpService.post(
      Uri.parse("$supportBaseURL/api/v3/support?account-uid=$accountUID"),
      data: {
        "appVersion": model.appVersion,
        "dateTime": model.dateTime,
        "phoneId": model.phoneId,
        "phoneType": model.phoneType,
        "phoneOsVersion": model.phoneOS,
        "wifiInternetSettings": model.wifiInternetSettings,
        "truVideoServer": model.truVideoServer,
        "memoryFree": model.freeVirtualMemory,
        "memoryTotal": model.totalPhysicalMemory,
        "storageFree": model.freeDiskSpace,
        "videoStored": model.videoStored,
        "oldVideosStored": "-",
        "locationServices": "-",
        "location": "-",
        "accessToMicrophone": model.microphoneAccess,
        "notifications": model.notificationAccess,
        "googlePlayAccount": "-",
        "networkType": model.networkType,
        "networkTest": "-",
        "bandwidthTest": model.bandwidthTest,
        "videoSettings": model.recordingSettings,
        "comment": "-",
        "email": "-",
        "phoneNumber": "-",
        "storageCleanupSchedule": "-",
        "battery": model.batteryLevel,
        "videoFormat": model.videoFormat,
      },
      headers: {
        "x-authorization-truvideo": token,
      },
    );

    if (onProgressChange != null) onProgressChange("Completed!");
  }

  Future<String> checkWifiInternetSettings() async {
    final isOnline = await _connectivityService.isOnline();
    String wifiInternetSettings;
    if (isOnline) {
      wifiInternetSettings = "Internet Connected";
    } else {
      wifiInternetSettings = "Internet Not Connected";
    }
    return wifiInternetSettings;
  }

  Future<String> checkDiskSpaceAvailable() async {
    var freeDiskSpace = await DiskSpace.getFreeDiskSpace;

    final freeDiskString = freeDiskSpace != null ? filesize((freeDiskSpace * 1048576).round()) : '-';
    return freeDiskString;
  }

  Future<String> checkVideoSize() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final videosDirectory = Directory("${documentsDirectory.path}/temp-videos");
    int totalSize = 0;

    try {
      if (videosDirectory.existsSync()) {
        videosDirectory.listSync(recursive: true, followLinks: false).forEach((FileSystemEntity entity) {
          if (entity is File) {
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      log(e.toString());
    }

    return filesize(totalSize);
  }

  Future<String> checkRecordingSettings() async {
    String result = '';
    final SettingsService service = GetIt.I.get();
    final cameraQuality = await service.getCameraQuality();

    switch (cameraQuality) {
      case CameraQuality.low:
        result = Platform.isIOS ? '352x288' : '320x240';
        break;
      case CameraQuality.medium:
        result = Platform.isIOS ? '640x480' : '720x480';
        break;
      case CameraQuality.high:
        result = '1280x720';
        break;
    }
    return result;
  }

  Future<String> checkTruVideoServer() async {
    final token = await _authService.token;

    try {
      await _httpService.get(
        Uri.parse(baseURL),
        headers: {
          "x-authorization-truvideo": token,
        },
      );
      return "Connected";
    } catch (error) {
      return "Not Connected";
    }
  }
}

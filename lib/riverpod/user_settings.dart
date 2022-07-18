import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/video_tag_model.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/model/video_type_model.dart';

final userSettingsPod = StateProvider<List<UserSettingsModel>>((ref) => <UserSettingsModel>[]);

extension UserSettingsExtension on List<UserSettingsModel> {
  bool get isAppTypeRepairOrder {
    final appTypeSetting = firstWhereOrNull((element) => element.key == "appType");
    if (appTypeSetting == null) return false;
    return appTypeSetting.value == "SERVICE";
  }

  bool get isVideoTagEnabled {
    final item = firstWhereOrNull((e) => e.key == "tag-enabled");
    if (item == null) return false;
    return item.value == "true";
  }

  List<VideoTagModel> get videoTags {
    if (!isVideoTagEnabled) return <VideoTagModel>[];

    if (any((e) => e.key == "video-tags")) {
      final tagsSetting = firstWhereOrNull((e) => e.key == "video-tags");
      if (tagsSetting == null) return <VideoTagModel>[];
      final children = tagsSetting.children ?? [];
      return children
          .map((e) => VideoTagModel(
                key: e.key,
                displayName: e.displayName ?? '',
                type: e.type,
                value: e.value ?? '',
              ))
          .toList();
    } else {
      return <VideoTagModel>[];
    }
  }

  List<VideoTypeModel> get videoTypes {
    return [
      VideoTypeModel(id: "PHONE_UP", description: "Phone-up"),
      VideoTypeModel(id: "INTERNET_INQUIRY", description: "Internet Inquiry"),
      VideoTypeModel(id: "BE_BACK", description: "Be-back"),
      VideoTypeModel(id: "EVERGREEN", description: "Evergreen"),
      VideoTypeModel(id: "SALES_AGENT_INTRO", description: "Sales Agent Intro"),
      VideoTypeModel(id: "TESTIMONIAL", description: "Testimonial"),
      VideoTypeModel(id: "PRE_DELIVERY", description: "Pre-delivery"),
    ];
  }

  String get fileBucketName {
    final setting = firstWhereOrNull((e) => e.key == "enterprise-storage");
    if (setting == null) return "";
    return setting.children?.firstWhereOrNull((e) => e.key == "bucket-name")?.value ?? "";
  }

  String get fileBucketRegion {
    final setting = firstWhereOrNull((e) => e.key == "enterprise-storage");
    if (setting == null) return "";
    return setting.children?.firstWhereOrNull((e) => e.key == "bucket-region")?.value ?? "";
  }

  String get fileBucketPoolID {
    final setting = firstWhereOrNull((e) => e.key == "enterprise-storage");
    if (setting == null) return "";
    return setting.children?.firstWhereOrNull((e) => e.key == "identity-pool-id")?.value ?? "";
  }
}

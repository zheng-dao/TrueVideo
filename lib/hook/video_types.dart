import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/video_type_model.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';

List<VideoTypeModel> useVideoTypes(WidgetRef ref) {
  final settings = ref.watch(userSettingsPod);

  return useMemoized(
    () => settings.videoTypes,
    [settings],
  );
}

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';

CameraQuality useCameraQuality(WidgetRef ref) {
  final SettingsService service = GetIt.I.get();
  final auth = ref.watch(authPod);
  final stream = useStream(
    useMemoized(() => service.streamCameraQuality(), [auth?.publicUserUuid]),
    initialData: CameraQuality.medium,
  );

  return stream.data ?? CameraQuality.medium;
}

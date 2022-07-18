import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/service/settings/_interface.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';

SettingsFontSize useFontSize(WidgetRef ref) {
  final SettingsService service = GetIt.I.get();
  final auth = ref.watch(authPod);
  final stream = useStream(
    useMemoized(() => service.streamFontSize(), [auth?.publicUserUuid]),
    initialData: SettingsFontSize.medium,
  );

  return stream.data ?? SettingsFontSize.medium;
}

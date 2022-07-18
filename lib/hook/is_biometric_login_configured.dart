import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/service/biometric_login/_interface.dart';

bool useIsBiometricLoginConfigured(WidgetRef ref, {String? userUUID}) {
  final BiometricLoginService biometricLoginService = GetIt.I.get();
  final auth = ref.watch(authPod);
  userUUID = userUUID ?? auth?.publicUserUuid ?? "";

  final initialValue = useMemoized(() => biometricLoginService.getStatus(userUUID ?? ""), [userUUID]);
  final stream = useStream(
    useMemoized(
      () => biometricLoginService.streamStatus(userUUID ?? ""),
      [userUUID],
    ),
    initialData: initialValue,
  );

  return stream.data ?? initialValue;
}

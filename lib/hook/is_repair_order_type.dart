import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';

bool useIsAppTypeRepairOrder(WidgetRef ref) {
  final userData = ref.watch(userSettingsPod);
  return useMemoized(
    () => (userData.firstWhereOrNull((element) => element.key == "appType")?.value ?? "") == "SERVICE",
    [userData],
  );
}

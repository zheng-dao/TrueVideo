import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/connectivity.dart';

bool useIsOnline(WidgetRef ref) {
  return ref.watch(connectivityPod);
}

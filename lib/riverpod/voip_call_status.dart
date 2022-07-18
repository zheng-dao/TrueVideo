import 'package:hooks_riverpod/hooks_riverpod.dart';

enum VoipCallStatus {
  nothing,
  loading,
  ready,
  error,
}

final voipCallStatusPod = StateProvider<VoipCallStatus>((ref) => VoipCallStatus.nothing);

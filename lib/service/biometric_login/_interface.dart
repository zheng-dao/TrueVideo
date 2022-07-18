abstract class BiometricLoginService {
  Future<void> store({
    required String userUUID,
    required String dealerCode,
    required String pin,
  });

  Future<String> read(String userUUID);

  Future<void> delete(String userUUID);

  Stream<bool> streamStatus(String userUUID);

  bool getStatus(String userUUID);

  bool shouldAskLink(String userUUID);

  Future<void> markNeverAskAgainLink(String userUUID);
}

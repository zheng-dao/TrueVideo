abstract class FileBucketService {
  Future<String> upload(
    String filePath, {
    String fileName = "",
    String folder = "",
    required String bucketName,
    required String region,
    required String poolID,
    Function(double progress)? onProgressChange,
  });
}

import 'dart:io';

import 'package:truvideo_enterprise/service/file_bucket/_interface.dart';

import 'custom_simple_s3.dart';

class FileBucketS3ServiceImpl extends FileBucketService {
  @override
  Future<String> upload(
    String filePath, {
    String fileName = "",
    String folder = "",
    Function(double progress)? onProgressChange,
    required String bucketName,
    required String region,
    required String poolID,
  }) async {
    final simpleS3 = CustomSimpleS3();

    final listener = simpleS3.getUploadPercentage.listen((event) {
      try {
        onProgressChange?.call(double.parse(event.toString()).clamp(0.0, 100.0));
      } catch (_) {}
    });

    String result = await simpleS3.uploadFile(
      File(filePath),
      bucketName,
      poolID,
      CustomAWSRegion(region),
      fileName: fileName.trim().isNotEmpty ? fileName : null,
      debugLog: true,
      s3FolderPath: folder,
      accessControl: S3AccessControl.publicReadWrite,
    );

    listener.cancel();

    return result;
  }
}

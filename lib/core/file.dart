import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;

class CustomFileUtils {
  static Future<String> generateTempDocumentPath(String extension) async {
    final Directory tempFolder = await path.getApplicationDocumentsDirectory();
    final String dirPath = '${tempFolder.path}/temp-documents';
    await Directory(dirPath).create(recursive: true);
    return "$dirPath/${DateTime.now().microsecondsSinceEpoch}.$extension";
  }

  static Future<String> generateTempVideoPath(String extension) async {
    final Directory tempFolder = await path.getApplicationDocumentsDirectory();
    final String dirPath = '${tempFolder.path}/temp-videos';
    await Directory(dirPath).create(recursive: true);
    return "$dirPath/${DateTime.now().microsecondsSinceEpoch}.$extension";
  }

  static Future<String> generateTempImagePath(String extension) async {
    final Directory tempFolder = await path.getApplicationDocumentsDirectory();
    final String dirPath = '${tempFolder.path}/temp-images';
    await Directory(dirPath).create(recursive: true);
    return "$dirPath/${DateTime.now().microsecondsSinceEpoch}.$extension";
  }

  static bool delete(String path) {
    final f = File(path);
    if (!f.existsSync()) return true;
    try {
      f.deleteSync();
      log("File $path deleted");
      return true;
    } catch (error) {
      log("Error deleting $path", error: error);
      return false;
    }
  }
}

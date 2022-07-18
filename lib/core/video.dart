import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_ffmpeg/completed_ffmpeg_execution.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/model/camera/video_info.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CustomVideoUtils {
  static final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  static final FlutterFFprobe _flutterFFprobe = FlutterFFprobe();
  static final FlutterFFmpegConfig _flutterFFmpegConfig = FlutterFFmpegConfig();

  static Future<VideoInfoModel> getInfo(String filePath) async {
    _flutterFFmpegConfig.disableLogs();

    var rotationResult = await _flutterFFprobe.execute('-i "$filePath"');
    if (rotationResult != 0) {
      final output = await _flutterFFmpegConfig.getLastCommandOutput();
      log("Output: $output");
      throw CustomException();
    }

    var processResult = await _flutterFFprobe.execute('-v error  -select_streams v:0 -show_streams "$filePath"');
    if (processResult != 0) {
      final output = await _flutterFFmpegConfig.getLastCommandOutput();
      log("Output: $output");
      throw CustomException();
    }

    final videoSize = await File(filePath).length();

    var info = VideoInfoModel(
      path: filePath,
      durationMillis: 0,
      width: 0.0,
      height: 0.0,
      rotation: 0,
      size: videoSize,
    );

    final rotationOutput = await _flutterFFmpegConfig.getLastCommandOutput();
    rotationOutput.split("\n").forEach((element) {
      if (element.startsWith("rotation=")) {
        int? value = int.tryParse(element.replaceAll("rotation=", ""));
        info = info.copyWith(rotation: value ?? 0);
      }
    });

    var ouput = await _flutterFFmpegConfig.getLastCommandOutput();

    ouput.split("\n").forEach((element) {
      if (element.startsWith("width=")) {
        double? value = double.tryParse(element.replaceAll("width=", ""));
        info = info.copyWith(width: value ?? 0.0);
      }

      if (element.startsWith("height=")) {
        double? value = double.tryParse(element.replaceAll("height=", ""));
        info = info.copyWith(height: value ?? 0.0);
      }

      if (element.startsWith("duration=")) {
        double? value = double.tryParse(element.replaceAll("duration=", ""));
        info = info.copyWith(durationMillis: ((value ?? 0.0) * 1000).floor());
      }
    });

    return info;
  }

  static Future<String> rotate(String filePath, double rotation) async {
    _flutterFFmpegConfig.disableLogs();

    final extension = filePath.split(".").last;
    final destinationPath = await CustomFileUtils.generateTempVideoPath(extension);

    final command = '-i  "$filePath" -c:v copy -c:a copy -metadata:s:v:0 rotate=$rotation "$destinationPath"';
    int processResult = await _flutterFFmpeg.execute(command);
    if (processResult != 0) {
      final output = await _flutterFFmpegConfig.getLastCommandOutput();
      log("Error rotating: $output");
      throw CustomException(message: output);
    }

    return destinationPath;
  }

  static Future<String> concat(
    List<String> filePaths, {
    Function(int id)? onExecutionId,
    Function(double progress)? onProgress,
  }) async {
    _flutterFFmpegConfig.disableLogs();

    final completer = Completer<String>();

    final extension = filePaths[0].split(".").last;
    final destinationPath = await CustomFileUtils.generateTempVideoPath(extension);

    int duration = 0;
    for (var path in filePaths) {
      try {
        final media = await getInfo(path);
        duration += media.durationMillis;
      } catch (_) {}
    }

    final filesPath = await CustomFileUtils.generateTempDocumentPath("txt");
    String filesContent = "";
    for (var element in filePaths) {
      if (filesContent.trim().isNotEmpty) {
        filesContent += "\n";
      }

      filesContent += "file '$element'";
    }

    await File(filesPath).writeAsString(filesContent);

    var command = '-f concat -safe 0 -i $filesPath -c copy $destinationPath';

    onProgress?.call(0.0);
    _flutterFFmpegConfig.disableStatistics();
    _flutterFFmpegConfig.enableStatistics();
    _flutterFFmpegConfig.enableStatisticsCallback((x) {
      double percentage = ((x.time / 1000) / duration) * 100;
      onProgress?.call(percentage.clamp(0.0, 100.0));
    });

    final id = await _flutterFFmpeg.executeAsync(command, (CompletedFFmpegExecution c) async {
      _flutterFFmpegConfig.disableStatistics();

      if (c.returnCode == 255) return;
      if (c.returnCode != 0) {
        final output = await _flutterFFmpegConfig.getLastCommandOutput();
        log("Error concat. $output");
        completer.completeError(CustomException());
      } else {
        onProgress?.call(100.0);
        completer.complete(destinationPath);
      }
      await File(filesPath).delete();
    });
    onExecutionId?.call(id);
    return completer.future;
  }

  static Future<String> getThumbnail(String filePath) async {
    _flutterFFmpegConfig.disableLogs();

    final destinationPath = await CustomFileUtils.generateTempImagePath("png");
    var mediaInfo = await getInfo(filePath);
    String thumbnailSecond = "01";
    if (mediaInfo.durationMillis < 1000) {
      thumbnailSecond = "00";
    }

    final command = '-i "$filePath" -ss 00:00:$thumbnailSecond -vframes 1 $destinationPath';
    int processResult = await _flutterFFmpeg.execute(command);
    if (processResult != 0) {
      throw CustomException();
    }
    return destinationPath;
  }

  static Stream<List<Uint8List?>> streamThumbnails({
    required String filePath,
    required int numberOfThumbnails,
    Function(Duration duration)? onVideoDuration,
  }) async* {
    if (!File(filePath).existsSync()) throw CustomException(message: "File not found");
    final videoMedia = await getInfo(filePath);

    final double interval = videoMedia.durationMillis / numberOfThumbnails;
    final List<Uint8List?> byteList = [];

    onVideoDuration?.call(Duration(milliseconds: videoMedia.durationMillis));

    // the cache of last thumbnail
    Uint8List? lastBytes;

    for (int i = 1; i <= numberOfThumbnails; i++) {
      Uint8List? bytes;

      if (!(await File(filePath).exists())) throw CustomException(message: "File not found");

      bytes = await VideoThumbnail.thumbnailData(
        video: filePath,
        imageFormat: ImageFormat.PNG,
        timeMs: (interval * i).toInt(),
        quality: 50,
        maxWidth: 100,
        maxHeight: 100,
      );

      // if current thumbnail is null use the last thumbnail
      if (bytes != null) {
        lastBytes = bytes;
      } else {
        bytes = lastBytes;
      }

      byteList.add(bytes);

      yield byteList;
    }
  }

  static Future<String> trim(String filePath, Duration start, Duration end) async {
    _flutterFFmpegConfig.disableLogs();

    final extension = filePath.split(".").last;
    final destinationPath = await CustomFileUtils.generateTempVideoPath(extension);

    final command = '-ss $start -to $end -i $filePath -async 1 -c:v copy -c:a copy $destinationPath';
    int processResult = await _flutterFFmpeg.execute(command);
    if (processResult != 0) {
      final output = await _flutterFFmpegConfig.getLastCommandOutput();
      log("Error trimming: $output");
      throw CustomException();
    }

    return destinationPath;
  }

  static Future<String> encode(String filePath) async {
    _flutterFFmpegConfig.disableLogs();

    final destinationPath = await CustomFileUtils.generateTempVideoPath("mp4");

    final command = '-i $filePath -vcodec libx264 -acodec aac $destinationPath';
    int processResult = await _flutterFFmpeg.execute(command);
    if (processResult != 0) {
      final output = await _flutterFFmpegConfig.getLastCommandOutput();
      log("Error trimming: $output");
      throw CustomException();
    }

    return destinationPath;
  }
}

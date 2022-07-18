import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/file.dart';
import 'package:truvideo_enterprise/service/picture/_interface.dart';
import 'package:image/image.dart' as img;

class PictureServiceImpl extends PictureService {
  @override
  Future<Size> getSize(String path) {
    return compute<String, Size>(_processGetSize, path);
  }

  @override
  Future<String> compress(
    String path, {
    int quality = 80,
    String destinationPath = "",
  }) async {
    final extension = path.split(".").last;
    String resultPath;
    if (destinationPath.trim().isEmpty) {
      resultPath = await CustomFileUtils.generateTempImagePath(extension);
    } else {
      resultPath = destinationPath;
    }

    final imageBytes = await File(path).readAsBytes();
    final converted = await FlutterImageCompress.compressWithList(
      imageBytes,
      quality: quality.clamp(0, 100),
      format: CompressFormat.png,
    );
    await File(resultPath).writeAsBytes(converted);
    return resultPath;
  }

  @override
  Future<String> edit(
    String path, {
    double rotation = 0.0,
    bool flipHorizontal = false,
    bool flipVertical = false,
    String destinationPath = "",
  }) async {
    final extension = path.split(".").last;
    String resultPath;
    if (destinationPath.trim().isEmpty) {
      resultPath = await CustomFileUtils.generateTempImagePath(extension);
    } else {
      resultPath = destinationPath;
    }

    return await compute<_EditParams, String>(
      _processEdit,
      _EditParams(
        path: path,
        destinationPath: resultPath,
        rotation: rotation,
        flipHorizontal: flipHorizontal,
        flipVertical: flipVertical,
      ),
    );
  }
}

Future<Size> _processGetSize(String path) async {
  final bytes = await File(path).readAsBytes();
  final image = img.decodeImage(bytes);
  if (image == null) throw CustomException();

  return Size(
    image.width.toDouble(),
    image.height.toDouble(),
  );
}

Future<String> _processEdit(_EditParams params) async {
  var bytes = await File(params.path).readAsBytes();
  var image = img.decodeImage(bytes);
  if (image == null) throw CustomException();

  if (params.rotation != 0.0) {
    image = img.copyRotate(image, params.rotation);
  }

  if (params.flipHorizontal) {
    image = img.flipHorizontal(image);
  }

  if (params.flipVertical) {
    image = img.flipVertical(image);
  }

  bytes = Uint8List.fromList(img.encodePng(image));
  File(params.destinationPath).writeAsBytesSync(bytes);
  return params.destinationPath;
}

class _EditParams {
  final String path;
  final String destinationPath;
  final double rotation;
  final bool flipHorizontal;
  final bool flipVertical;

  _EditParams({
    required this.path,
    required this.destinationPath,
    required this.rotation,
    required this.flipHorizontal,
    required this.flipVertical,
  });
}

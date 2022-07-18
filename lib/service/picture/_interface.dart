import 'package:flutter/widgets.dart';

abstract class PictureService {
  Future<Size> getSize(String path);

  Future<String> edit(
    String path, {
    double rotation = 0.0,
    bool flipHorizontal = false,
    bool flipVertical = false,
    String destinationPath = "",
  });

  Future<String> compress(
    String path, {
    int quality = 80,
    String destinationPath = "",
  });
}

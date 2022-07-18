import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/service/settings/font_size.dart';

abstract class SettingsService {
  Future<void> setDebug(bool debug);

  Future<bool> isDebug();

  Stream<bool> streamIsDebug();

  Future<void> setFontSize(SettingsFontSize fontSize);

  Future<SettingsFontSize> getFontSize();

  Stream<SettingsFontSize> streamFontSize();

  Future<void> setCameraQuality(CameraQuality cameraQuality);

  Future<CameraQuality> getCameraQuality();

  Stream<CameraQuality> streamCameraQuality();
}

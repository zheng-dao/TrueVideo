
import 'index.dart';

class CustomVideoPlayerController {
  CustomVideoPlayerState? _state;

  attach(CustomVideoPlayerState? state) {
    _state = state;
  }

  Future<void> play() async {
    await _state?.play();
  }

  Future<void> pause() async {
    await _state?.pause();
  }

  Future<void> seek(Duration position) async {
    await _state?.seek(position);
  }

  bool get isPlaying {
    return _state?.isPlaying ?? false;
  }

  set controlsVisible(bool value) {
    _state?.controlsVisible = value;
  }
}

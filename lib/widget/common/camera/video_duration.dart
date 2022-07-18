import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';

class CustomCameraVideoDuration extends StatelessWidget {
  final Duration duration;
  final bool recording;
  final bool recordingPaused;

  const CustomCameraVideoDuration({
    Key? key,
    required this.duration,
    this.recording = false,
    this.recordingPaused = false,
  }) : super(key: key);

  DateService get _dateService => GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 30.0,
      width: 120,
      decoration: BoxDecoration(
        color: recording ? (recordingPaused ? Colors.black.withOpacity(0.4) : Colors.red) : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(letterSpacing: 2, color: Colors.white) ?? const TextStyle(),
          child: Text(
            _dateService.duration(duration),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

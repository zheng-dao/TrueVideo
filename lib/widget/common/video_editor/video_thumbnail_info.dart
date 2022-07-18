import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';

class CustomCameraVideoResultThumbnailInfo extends StatelessWidget {
  final double startPosition;
  final double endPosition;
  final double currentPosition;
  final bool draggingHandler;
  final Duration start;
  final Duration end;
  final Duration current;
  final ValueNotifier<Duration> position;
  final bool draggingCurrent;

  const CustomCameraVideoResultThumbnailInfo({
    Key? key,
    required this.startPosition,
    required this.endPosition,
    required this.currentPosition,
    required this.draggingHandler,
    required this.start,
    required this.end,
    required this.current,
    required this.position,
    required this.draggingCurrent,
  }) : super(key: key);

  String _trimmedDuration(Duration start, Duration end) {
    final d = end - start;
    if (d.inMilliseconds < 1000) {
      return "${(d.inMilliseconds / 1000).toStringAsFixed(1)}s";
    }

    final DateService dateService = GetIt.I.get();
    return dateService.duration(d);
  }

  @override
  Widget build(BuildContext context) {
    final DateService dateService = GetIt.I.get();

    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 8.0),
      color: Colors.transparent,
      width: double.infinity,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          // Line
          Positioned(
            left: startPosition,
            width: endPosition - startPosition,
            top: 0,
            bottom: 0,
            child: CustomAnimatedFadeVisibility(
              visible: draggingHandler,
              child: Center(
                child: Container(
                  height: 2,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
          ),

          // Start position
          Positioned(
            top: 0,
            bottom: 0,
            left: startPosition,
            child: CustomAnimatedFadeVisibility(
              visible: draggingHandler,
              child: Center(
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Text(
                      dateService.duration(start),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // End position
          Positioned(
            top: 0,
            bottom: 0,
            left: endPosition,
            child: CustomAnimatedFadeVisibility(
              visible: draggingHandler,
              child: Center(
                child: FractionalTranslation(
                  translation: const Offset(-0.5, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Text(
                      dateService.duration(end),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Trimmed duration
          Positioned(
            top: 0,
            bottom: 0,
            left: (endPosition + startPosition) / 2,
            child: CustomAnimatedFadeVisibility(
              visible: draggingHandler,
              child: FractionalTranslation(
                translation: const Offset(-0.5, 0.0),
                child: Center(
                  child: MultiValueListenableBuilder(
                    valueListenables: [position],
                    builder: (context, values, child) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                      child: Text(
                        _trimmedDuration(start, end),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Current
          Positioned(
            top: 0,
            bottom: 0,
            left: currentPosition,
            child: CustomAnimatedFadeVisibility(
              visible: draggingCurrent,
              child: FractionalTranslation(
                translation: const Offset(-0.5, 0.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                    child: Text(
                      dateService.duration(current),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

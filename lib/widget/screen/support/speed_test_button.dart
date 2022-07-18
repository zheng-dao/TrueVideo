import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_text_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';

class CustomSpeedTestButton extends StatefulWidget {
  final Function(double speed)? onPressed;

  const CustomSpeedTestButton({Key? key, this.onPressed}) : super(key: key);

  @override
  State<CustomSpeedTestButton> createState() => _CustomSpeedTestButtonState();
}

class _CustomSpeedTestButtonState extends State<CustomSpeedTestButton> {
  bool _running = false;
  dynamic _error;
  double? _result;
  double _percentage = 0.0;

  Color get _color {
    if (_error != null) return Colors.red.shade600;
    return Theme.of(context).colorScheme.secondary;
  }

  String get _text {
    if (_error != null) {
      if (_error is CustomException) {
        return (_error as CustomException).message ?? "ERROR";
      }

      return "ERROR";
    }

    if (_running) return "RUNNING BANDWIDTH TEST";
    return "CONTINUE";
  }

  _onPressed() async {
    if (_running) return;

    await _runSpeedTest();
    if (_error != null) return;

    widget.onPressed?.call(_result ?? 0.0);
  }

  _runSpeedTest() async {
    setState(() {
      _running = true;
      _error = null;
      _result = 0.0;
      _percentage = 0.0;
    });

    final ConnectivityService connectivityService = GetIt.I.get();
    try {
      final speed = await connectivityService.runBandwidthTest(
        callback: (speed, percentage) {
          if (!mounted) return;

          setState(() {
            _result = speed;
            _percentage = percentage;
          });
        },
      );

      if (!mounted) return;

      setState(() {
        _percentage = 100.0;
        _running = false;
        _result = speed;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _running = false;
        _error = error;
        _result = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              // Background
              CustomAnimatedFadeVisibility(
                visible: _error == null,
                child: CustomGradientButton(
                  height: 50,
                  width: double.infinity,
                  gradient: CustomColorsUtils.gradient,
                ),
              ),
              CustomAnimatedFadeVisibility(
                visible: _error != null,
                child: CustomGradientButton(
                  height: 50,
                  width: double.infinity,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red.shade600,
                      Colors.red.shade300,
                    ],
                  ),
                ),
              ),
              // AnimatedContainer(
              //   duration: const Duration(microseconds: 300),
              //   height: 50,
              //   width: double.infinity,
              //   color: _color,
              // ),

              // Progress
              CustomAnimatedFadeVisibility(
                visible: _running,
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  height: 50,
                  width: _percentage * constraints.maxWidth,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              // Text
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAnimatedTextSwitcher(
                      text: _text,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _color.contrast(context),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                    ),
                    CustomAnimatedCollapseVisibility(
                      visible: _result != null && _error == null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomAnimatedCollapseVisibility(
                            axis: Axis.horizontal,
                            visible: _running,
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              width: 10,
                              height: 10,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                          CustomAnimatedCollapseVisibility(
                            axis: Axis.horizontal,
                            visible: !_running,
                            child: Text(
                              "Internet speed: ",
                              style: Theme.of(context).textTheme.caption?.copyWith(color: _color.contrast(context)),
                            ),
                          ),
                          Text(
                            "${(_result ?? 0.0).toStringAsFixed(2)} MB/s",
                            style: Theme.of(context).textTheme.caption?.copyWith(color: _color.contrast(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomRipple(
                onPressed: _onPressed,
              ),
            ],
          );
        }),
      ),
    );
  }
}

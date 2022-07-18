import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'dart:math' as math;

class CustomCameraCapturingPicture extends StatefulWidget {
  const CustomCameraCapturingPicture({Key? key}) : super(key: key);

  @override
  State<CustomCameraCapturingPicture> createState() => CustomCameraCapturingPictureState();
}

class CustomCameraCapturingPictureState extends State<CustomCameraCapturingPicture> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late Animation<double> _imageOpacity;
  late Animation<Size> _size;
  late Animation<Offset> _position;
  late Animation<double> _borderRadius;

  bool _flipHorizontal = false;
  CustomImageDataSource? _imageDataSource;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    _opacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _imageOpacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _size = Tween<Size>(begin: Size.zero, end: Size.zero).animate(_animationController);
    _position = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_animationController);
    _borderRadius = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  showCapturing({
    required Size size,
    required Offset position,
  }) async {
    setState(() {
      _imageDataSource = null;
    });

    _opacity = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_animationController);

    _imageOpacity = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_animationController);

    _size = Tween<Size>(
      begin: size,
      end: size,
    ).animate(_animationController);

    _position = Tween<Offset>(
      begin: position,
      end: position,
    ).animate(_animationController);

    _borderRadius = Tween<double>(
      begin: 0.0,
      end: 0.0,
    ).animate(_animationController);

    _animationController.stop();
    _animationController.reset();
    _animationController.value = 1.0;

    await CustomWidgetUtils.wait();
    if (!mounted) return;

    _opacity = Tween<double>(
      begin: _opacity.value,
      end: 1.0,
    ).animate(_animationController);

    _size = Tween<Size>(
      begin: size,
      end: size,
    ).animate(_animationController);

    _position = Tween<Offset>(
      begin: position,
      end: position,
    ).animate(_animationController);

    _animationController.reset();
    _animationController.duration = const Duration(milliseconds: 300);
    await _animationController.forward();
  }

  close({
    required Offset position,
    required Size size,
    CustomImageDataSource? imageDataSource,
    bool flipHorizontal = false,
  }) async {
    setState(() {
      _flipHorizontal = flipHorizontal;
      _imageDataSource = imageDataSource;
      _imageDataSource = imageDataSource;
    });

    _opacity = Tween<double>(
      begin: _opacity.value,
      end: 1.0,
    ).animate(_animationController);

    _imageOpacity = Tween<double>(
      begin: _imageOpacity.value,
      end: 0.0,
    ).animate(_animationController);

    _size = Tween<Size>(
      begin: _size.value,
      end: _size.value,
    ).animate(_animationController);

    _position = Tween<Offset>(
      begin: _position.value,
      end: _position.value,
    ).animate(_animationController);

    _borderRadius = Tween<double>(
      begin: _borderRadius.value,
      end: _borderRadius.value,
    ).animate(_animationController);

    _animationController.stop();
    _animationController.reset();
    _animationController.value = 1.0;

    await CustomWidgetUtils.wait();

    const x = 0.75;

    _opacity = Tween<double>(
      begin: _opacity.value,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          x,
          1.0,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _imageOpacity = Tween<double>(
      begin: _imageOpacity.value,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          x,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _size = Tween<Size>(
      begin: _size.value,
      end: size,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          x,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _position = Tween<Offset>(
      begin: _position.value,
      end: position,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          x,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _borderRadius = Tween<double>(
      begin: _borderRadius.value,
      end: 10.0,
    ).animate(_animationController);

    _animationController.reset();
    _animationController.duration = const Duration(milliseconds: 600);
    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: _position.value.dx,
                  top: _position.value.dy,
                  width: _size.value.width,
                  height: _size.value.height,
                  child: Opacity(
                    opacity: _opacity.value.clamp(0.0, 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_borderRadius.value),
                      child: child!,
                    ),
                  ),
                );
              },
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Opacity(
                    opacity: _imageOpacity.value.clamp(0.0, 1.0),
                    child: child!,
                  ),
                  child: Transform(
                    transform: _flipHorizontal ? (Matrix4.identity()..rotateY(math.pi)) : Matrix4.identity(),
                    alignment: Alignment.center,
                    child: CustomImage(
                      width: double.infinity,
                      height: double.infinity,
                      source: _imageDataSource,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';
import 'dart:math' as math;

class CustomKeypad extends StatelessWidget {
  final EdgeInsets? margin;
  final double maxButtonSize;
  final double horizontalMargin;
  final double verticalMargin;
  final MainAxisAlignment mainAxisAlignment;
  final Function(int number)? onNumberPressed;
  final Function()? onExtraButton1Pressed;
  final Function()? onExtraButton2Pressed;
  final Widget Function(BuildContext context, double size)? extraButton1Builder;
  final Widget Function(BuildContext context, double size)? extraButton2Builder;
  final bool extraButton1Visible;
  final bool extraButton2Visible;
  final Color? extraButton1Color;
  final Color? extraButton2Color;

  const CustomKeypad({
    Key? key,
    this.margin,
    this.maxButtonSize = 90,
    this.horizontalMargin = 8.0,
    this.verticalMargin = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.onNumberPressed,
    this.onExtraButton1Pressed,
    this.onExtraButton2Pressed,
    this.extraButton1Builder,
    this.extraButton2Builder,
    this.extraButton1Visible = false,
    this.extraButton2Visible = false,
    this.extraButton1Color,
    this.extraButton2Color,
  }) : super(key: key);

  Widget _buildNumber(BuildContext context, double size, int number) {
    return Text(
      number.toString(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: size * 0.3, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      child: LayoutBuilder(builder: (context, constraints) {
        final maxWidth = constraints.maxWidth - (horizontalMargin * 2);
        final maxHeight = constraints.maxHeight - (verticalMargin * 3);

        double h = maxHeight / 4;
        double w = maxWidth / 3;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  _Button(
                    color: CustomColorsUtils.divider,
                    margin: EdgeInsets.only(left: i != 0 ? horizontalMargin : 0.0),
                    builder: (context, size) => _buildNumber(context, size, i + 1),
                    width: w,
                    height: h,
                    maxSize: maxButtonSize,
                    onPressed: onNumberPressed == null ? null : () => onNumberPressed?.call(i + 1),
                  ),
              ],
            ),
            SizedBox(height: verticalMargin),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  _Button(
                    color: CustomColorsUtils.divider,
                    margin: EdgeInsets.only(left: i != 0 ? horizontalMargin : 0.0),
                    builder: (context, size) => _buildNumber(context, size, i + 4),
                    width: w,
                    height: h,
                    maxSize: maxButtonSize,
                    onPressed: onNumberPressed == null ? null : () => onNumberPressed?.call(i + 4),
                  ),
              ],
            ),
            SizedBox(height: verticalMargin),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  _Button(
                    color: CustomColorsUtils.divider,
                    margin: EdgeInsets.only(left: i != 0 ? horizontalMargin : 0.0),
                    builder: (context, size) => _buildNumber(context, size, i + 7),
                    width: w,
                    height: h,
                    maxSize: maxButtonSize,
                    onPressed: onNumberPressed == null ? null : () => onNumberPressed?.call(i + 7),
                  ),
              ],
            ),
            SizedBox(height: verticalMargin),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Builder(
                    builder: (context) {
                      Function()? onPressed;
                      bool visible = false;
                      Widget Function(BuildContext, double size)? builder;
                      Color? color;

                      if (i == 0) {
                        visible = extraButton1Visible;
                        onPressed = onExtraButton1Pressed;
                        builder = extraButton1Builder;
                        color = extraButton1Color;
                      }
                      if (i == 1) {
                        visible = true;
                        onPressed = onNumberPressed == null ? null : () => onNumberPressed?.call(0);
                        builder = (context, size) => _buildNumber(context, size, 0);
                      }
                      if (i == 2) {
                        visible = extraButton2Visible;
                        onPressed = onExtraButton2Pressed;
                        builder = extraButton2Builder;
                        color = extraButton2Color;
                      }
                      return _Button(
                        color: color ?? CustomColorsUtils.divider,
                        visible: visible,
                        margin: EdgeInsets.only(left: i != 0 ? horizontalMargin : 0.0),
                        width: w,
                        height: h,
                        maxSize: maxButtonSize,
                        onPressed: onPressed,
                        builder: builder ?? (context, size) => Container(),
                      );
                    },
                  ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _Button extends StatelessWidget {
  final double width;
  final double height;
  final double maxSize;
  final EdgeInsets? margin;
  final bool visible;
  final Function()? onPressed;
  final Widget Function(BuildContext context, double size) builder;
  final Color color;

  const _Button({
    Key? key,
    this.visible = true,
    this.width = 40.0,
    this.height = 40.0,
    this.maxSize = 56,
    this.margin,
    this.onPressed,
    required this.builder,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = math.min(width, height).clamp(0.0, maxSize);

    return CustomAnimatedFadeVisibility(
      visible: visible,
      child: Container(
        margin: margin,
        width: size,
        height: size,
        child: CustomRipple(
          onPressed: onPressed,
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(
            child: builder(context, size),
          ),
        ),
      ),
    );
  }
}

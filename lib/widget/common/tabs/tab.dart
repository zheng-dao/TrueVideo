import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';

class CustomTab extends StatelessWidget {
  final bool selected;
  final String text;
  final Widget? child;
  final Function()? onPressed;

  const CustomTab({
    Key? key,
    this.selected = false,
    this.text = "",
    required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRipple(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(4.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0).copyWith(bottom: 15),
            child: child ??
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline5!.copyWith(color: selected ? CustomColorsUtils.accent : null),
                ),
          ),
          Positioned(
            left: 5,
            right: 5,
            bottom: 10,
            child: CustomAnimatedFadeVisibility(
              visible: selected,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColorsUtils.accent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColorsUtils.accent.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Container(height: 4.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

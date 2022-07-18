import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';

class ChecklistColorOptionWidget extends StatelessWidget {
  final Color color;
  final bool anySelected;
  final Function()? onPressed;
  final String text;
  final double width;
  final bool selected;

  const ChecklistColorOptionWidget({
    Key? key,
    this.anySelected = false,
    this.selected = false,
    required this.color,
    this.onPressed,
    this.text = "",
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color currentColor;
    Color currentTextColor;

    if (anySelected) {
      currentColor = color.withOpacity(selected ? 1.0 : 0.1);
      currentTextColor = selected ? currentColor.contrast(context) : Colors.black;
    } else {
      currentColor = color.withOpacity(0.5);
      currentTextColor = Colors.black;
    }

    return CustomRipple(
      onPressed: onPressed,
      color: currentColor,
      child: SizedBox(
        width: width,
        height: 50,
        child: Stack(
          children: [
            CustomAnimatedFadeVisibility(
              visible: selected,
              child: Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
                ),
              ),
            ),
            if (text.trim().isNotEmpty)
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: currentTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

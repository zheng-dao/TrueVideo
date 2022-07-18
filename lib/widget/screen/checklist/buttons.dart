import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_translation/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';

class CheckListButtons extends StatelessWidget {
  final bool visible;
  final Function()? onButtonMarkAsGreenPressed;
  final Function()? onButtonSubmitPressed;
  final bool submitEnabled;
  final bool submitLoading;
  final bool markAsGreenEnabled;

  const CheckListButtons({
    Key? key,
    this.visible = true,
    this.onButtonMarkAsGreenPressed,
    this.onButtonSubmitPressed,
    this.submitEnabled = true,
    this.submitLoading = false, this.markAsGreenEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return CustomAnimatedTranslation(
      translation: visible ? Offset.zero : const Offset(0.0, 150),
      child: CustomAnimatedFadeVisibility(
        visible: visible,
        child: Column(
          children: [
            Container(
              height: 16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withOpacity(0.0),
                    color,
                  ],
                ),
              ),
            ),
            Container(
              color: color,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                  children: [
                    CustomBorderButton(
                      width: double.infinity,
                      text: "Mark all as green",
                      onPressed: onButtonMarkAsGreenPressed,
                      enabled: markAsGreenEnabled,
                    ),
                    const SizedBox(height: 16.0),
                    CustomGradientButton(
                      width: double.infinity,
                      gradient: CustomColorsUtils.gradient,
                      text: "SUBMIT INSPECTION",
                      onPressed: onButtonSubmitPressed,
                      enabled: submitEnabled,
                      loading: submitLoading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

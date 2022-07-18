import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';

class CustomListIndicatorEmpty extends StatelessWidget {
  final String title;
  final String message;
  final IconData? buttonIcon;
  final String buttonText;
  final Function()? onButtonPressed;

  const CustomListIndicatorEmpty({
    Key? key,
    this.onButtonPressed,
    this.title = "No items found",
    this.message = "",
    this.buttonText = "",
    this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final withTitle = title.trim().isNotEmpty;
    final withMessage = message.trim().isNotEmpty;
    final buttonVisible = buttonText.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (withTitle)
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
          if (withTitle)
            Container(
              margin: EdgeInsets.only(top: withTitle ? 8.0 : 0.0),
              child: Text(message, textAlign: TextAlign.center),
            ),
          if (buttonVisible)
            CustomGradientButton(
              margin: EdgeInsets.only(top: (withTitle || withMessage) ? 32 : 0.0),
              borderRadius: 100.0,
              elevation: 4,
              icon: buttonIcon,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              gradient: CustomColorsUtils.gradient,
              text: buttonText,
              onPressed: onButtonPressed,
            ),
        ],
      ),
    );
  }
}

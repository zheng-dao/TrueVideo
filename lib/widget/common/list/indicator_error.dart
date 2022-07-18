import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';

class CustomListIndicatorError extends StatelessWidget {
  final String title;
  final String message;
  final dynamic error;
  final IconData? buttonIcon;
  final String buttonText;
  final Function()? onButtonPressed;

  const CustomListIndicatorError({
    Key? key,
    this.onButtonPressed,
    this.title = "Something went wrong",
    this.message = "",
    this.buttonText = "Retry",
    this.buttonIcon,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentMessage = "";
    if (message.trim().isNotEmpty) {
      currentMessage = message;
    } else {
      if (error != null && error is CustomException) {
        currentMessage = (error as CustomException).message ?? "";
      } else {
        currentMessage = "Please, try again";
      }
    }

    final withTitle = title.trim().isNotEmpty;
    final withMessage = currentMessage.trim().isNotEmpty;
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
          if (withMessage)
            Container(
              margin: EdgeInsets.only(top: withTitle ? 8.0 : 0.0),
              child: Text(currentMessage, textAlign: TextAlign.center),
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

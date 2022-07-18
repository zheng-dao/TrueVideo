import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final bool underline;
  final Function()? onPressed;

  const CustomTextButton({
    Key? key,
    this.text = "",
    this.color,
    this.underline = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: color ?? Theme.of(context).colorScheme.secondary,
              decoration: underline ? TextDecoration.underline : null,
            ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextFieldError extends StatelessWidget {
  final String message;
  final Widget? child;
  final EdgeInsets? margin;

  const CustomTextFieldError({
    Key? key,
    this.message = "",
    this.child,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: margin ?? const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: double.infinity,
                alignment: Alignment.topLeft,
                key: ValueKey(message),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).errorColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

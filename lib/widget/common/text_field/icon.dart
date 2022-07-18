import 'package:flutter/material.dart';

class CustomTextFieldIconButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;
  final Color? iconColor;

  const CustomTextFieldIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: const CircleBorder(),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          icon,
          key: ValueKey(icon),
          size: 20,
          color: iconColor,
        ),
      ),
    );
  }
}

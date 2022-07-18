import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;
  final Color? textColor;

  const CustomChip({
    Key? key,
    this.text = "",
    this.color,
    this.onPressed,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fillColor = color ?? Theme.of(context).dividerColor;

    return RawMaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
      onPressed: onPressed,
      fillColor: fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 0,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textColor ?? fillColor.contrast(context)),
      ),
    );
  }
}

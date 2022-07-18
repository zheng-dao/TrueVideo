import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';

class SpeedTestStatusChip extends StatelessWidget {
  final String status;
  final Function()? onPressed;

  const SpeedTestStatusChip({
    Key? key,
    this.status = '',
    this.onPressed,
  }) : super(key: key);

  Color? _getStatusColor(BuildContext context) {
    return CustomColorsUtils.statusCancel;
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = _getStatusColor(context)?.withOpacity(0.1) ?? Theme.of(context).dividerColor;

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
        status,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: _getStatusColor(context) ?? fillColor.contrast(context)),
      ),
    );
  }
}

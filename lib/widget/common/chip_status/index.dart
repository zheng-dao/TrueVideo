import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/order_status.dart';

class CustomStatusChip extends StatelessWidget {
  final OrderStatusModel? status;
  final Function()? onPressed;

  const CustomStatusChip({
    Key? key,
    required this.status,
    this.onPressed,
  }) : super(key: key);

  Color? _getStatusColor(BuildContext context) {
    switch (status?.key) {
      case "STATUS_COMPLETE_CLOSED":
      case "STATUS_COMPLETE_VIEWED":
      case "STATUS_COMPLETE":
        return CustomColorsUtils.statusComplete;
      case "STATUS_CALLED":
      case "STATUS_SENT":
        return CustomColorsUtils.statusSent;
      case "STATUS_NEW":
      case "STATUS_CALLBACK":
        return CustomColorsUtils.statusNew;
      case "STATUS_REJECTED":
        return CustomColorsUtils.statusRejected;
      default:
        return null;
    }
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 0,
      child: Text(
        status?.value ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold, color: _getStatusColor(context) ?? fillColor.contrast(context)),
      ),
    );
  }
}

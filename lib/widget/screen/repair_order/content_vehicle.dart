import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';

class ScreenRepairOrderDetailVehicle extends StatelessWidget {
  final RepairOrderDetailModel model;
  final EdgeInsets? padding;

  const ScreenRepairOrderDetailVehicle({Key? key, required this.model, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String vehicle = (model.vehicle?.displayName ?? "").trim();
    bool withVehicle = vehicle.trim().isNotEmpty;

    return Container(
      margin: padding ?? const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Vehicle",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SelectableText(withVehicle ? vehicle : "No data"),
        ],
      ),
    );
  }
}

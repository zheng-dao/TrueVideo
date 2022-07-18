import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';


class ScreenRepairOrderDetailTechnician extends StatelessWidget {
  final RepairOrderDetailModel model;
  final EdgeInsets? padding;

  const ScreenRepairOrderDetailTechnician({
    Key? key,
    required this.model,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = (model.technician?.displayName ?? "").trim();
    final withName = name.trim().isNotEmpty;

    final email = (model.technician?.emailAddress ?? "").trim();
    final withEmail = email.trim().isNotEmpty;

    return Container(
      margin: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Technician",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(withName ? name : "No data"),
          Row(
            children: [
              const Icon(Icons.email_outlined, size: 15),
              const SizedBox(width: 4.0),
              SelectableText(withEmail ? email : "No data"),
            ],
          ),
        ],
      ),
    );
  }
}

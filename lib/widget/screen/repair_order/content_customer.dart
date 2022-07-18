import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';

class ScreenRepairOrderDetailCustomer extends StatelessWidget {
  final RepairOrderDetailModel model;
  final EdgeInsets? padding;

  const ScreenRepairOrderDetailCustomer({
    Key? key,
    required this.model,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = (model.customer?.displayName ?? "").trim();
    final withName = name.trim().isNotEmpty;

    final phoneNumber = model.customer?.mobileNumber ?? "";
    final withPhoneNumber = phoneNumber.trim().isNotEmpty;

    final email = model.customer?.email ?? "";
    final withEmail = email.trim().isNotEmpty;

    return Container(
      margin: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SelectableText(withName ? name : "No data"),
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 15),
              const SizedBox(width: 4.0),
              SelectableText(withPhoneNumber ? phoneNumber : "No data"),
            ],
          ),
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

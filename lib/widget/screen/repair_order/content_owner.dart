import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';


class ScreenRepairOrderDetailOwner extends HookConsumerWidget {
  final RepairOrderDetailModel model;
  final EdgeInsets? padding;

  const ScreenRepairOrderDetailOwner({
    Key? key,
    required this.model,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRepairOrderType = useIsAppTypeRepairOrder(ref);

    final name = (model.owner?.displayName ?? "").trim();
    final withName = name.trim().isNotEmpty;

    final email = (model.owner?.emailAddress ?? "").trim();
    final withEmail = email.trim().isNotEmpty;

    return Container(
      margin: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isRepairOrderType ? "Service Advisor" : "Sales Agent",
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

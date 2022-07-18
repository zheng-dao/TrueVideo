import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/chip_status/index.dart';

class ScreenRepairOrderHeader extends HookConsumerWidget {
  final EdgeInsets? padding;
  final RepairOrderDetailModel model;

  const ScreenRepairOrderHeader({
    Key? key,
    required this.model,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateService dateService = GetIt.I.get();
    final isRepairOrderType = useIsAppTypeRepairOrder(ref);
    final withJobServiceNumber = isRepairOrderType && model.jobServiceNumber.trim().isNotEmpty;
    final withCreateDate = model.createDate != null;

    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimatedCollapseVisibility(
                  visible: withJobServiceNumber,
                  child: AnimatedSwitcher(
                    key: ValueKey(model.jobServiceNumber),
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: double.infinity,
                      child: SelectableText(
                        withJobServiceNumber ? model.jobServiceNumber.trim() : "No number",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColorsUtils.accent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                CustomAnimatedCollapseVisibility(
                  visible: withCreateDate,
                  child: AnimatedSwitcher(
                    key: ValueKey(model.createDate),
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: double.infinity,
                      child: SelectableText(
                        withCreateDate ? dateService.formatDateTime(model.createDate!) : "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text('Status', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 8.0),
          CustomStatusChip(status: model.orderStatus),
        ],
      ),
    );
  }
}

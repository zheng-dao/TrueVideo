import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/chip_status/index.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class RepairOrderListItem extends HookConsumerWidget {
  final RepairOrderModel model;
  final bool selected;
  final Function(RepairOrderModel model)? onPressed;
  final Function(RepairOrderModel model)? onLongPressed;

  const RepairOrderListItem({
    Key? key,
    required this.model,
    this.selected = false,
    this.onPressed,
    this.onLongPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateService dateService = GetIt.I.get();
    final textColor = selected ? Theme.of(context).colorScheme.secondary : null;
    final isRepairOrderType = useIsAppTypeRepairOrder(ref);

    return CustomListTile(
      selected: selected,
      onPressed: onPressed == null ? null : () => onPressed?.call(model),
      onLongPressed: onLongPressed == null ? null : () => onLongPressed?.call(model),
      titleText: '${model.customer?.firstName} ${model.customer?.lastName}',
      subtitleText: model.createDate != null ? dateService.formatDateTime(model.createDate!) : '',
      leading: isRepairOrderType
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Center(
                    child: Text(
                      model.jobServiceNumber,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: textColor),
                    ),
                  ),
                ),
              ],
            )
          : null,
      trailing: CustomStatusChip(
        status: model.orderStatus,
      ),
    );
  }
}

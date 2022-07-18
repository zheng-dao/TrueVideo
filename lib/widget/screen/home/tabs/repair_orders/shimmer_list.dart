import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ScreenHomeRepairOrdersShimmer extends HookConsumerWidget {
  const ScreenHomeRepairOrdersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRepairOrderType = useIsAppTypeRepairOrder(ref);

    return Column(
      children: [
        Expanded(
          child: CustomShimmerList(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            length: 10,
            itemBuilder: (context, index) => CustomRepairOrderShimmerItem(isRepairOrderType: isRepairOrderType),
          ),
        ),
      ],
    );
  }
}

class CustomRepairOrderShimmerItem extends StatelessWidget {
  final bool isRepairOrderType;

  const CustomRepairOrderShimmerItem({Key? key, required this.isRepairOrderType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      leading: isRepairOrderType
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: 60,
                  height: 20,
                  child: const Text("askljdklasjd lkasjd"),
                ),
              ],
            )
          : null,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 25,
            color: Colors.white,
          ),
        ],
      ),
      title: Row(
        children: [
          Container(
            width: 100,
            color: Colors.white,
            child: const Text("lakjsdlkajsd"),
          ),
        ],
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Container(
              width: 120,
              color: Colors.white,
              child: const Text("lakjsdlkajsd"),
            ),
          ],
        ),
      ),
    );
  }
}

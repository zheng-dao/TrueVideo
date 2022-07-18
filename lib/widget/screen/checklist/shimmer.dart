import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/shimmer.dart';

class CheckListShimmer extends StatelessWidget {
  const CheckListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: CustomColorsUtils.divider,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                10,
                (index) => const _Item(),
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        CustomShimmerLine(
          width: double.infinity,
          height: 50,
          borderRadius: 0,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';

class ScreenRepairOrderDetailShimmer extends HookConsumerWidget {
  const ScreenRepairOrderDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTypeRO = useIsAppTypeRepairOrder(ref);

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).dividerColor,
        highlightColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 79,
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Container(
                          height: 20,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white,
            ),
            if (appTypeRO)
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CustomShimmerLine(width: double.infinity, height: 49),
                  ),
                  const CustomShimmerLine(width: double.infinity, height: 1),
                ],
              ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomShimmerLine(height: 18, width: 80),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 150),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 110),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 120),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
            const CustomShimmerLine(width: double.infinity, height: 1),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomShimmerLine(height: 18, width: 80),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 150),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 110),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
            const CustomShimmerLine(width: double.infinity, height: 1),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomShimmerLine(height: 18, width: 80),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 150),
                  SizedBox(height: 2.0),
                  CustomShimmerLine(height: 16, width: 110),
                  SizedBox(height: 4.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShimmerLine extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const CustomShimmerLine({Key? key, required this.width, required this.height, this.borderRadius = 4.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

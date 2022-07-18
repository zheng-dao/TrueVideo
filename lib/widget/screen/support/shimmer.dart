import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/shimmer.dart';

class ScreenSupportShimmer extends StatelessWidget {
  const ScreenSupportShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const CustomShimmerLine(width: 85, height: 20),
            ),
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Column(
              children: const [
                CustomShimmerLine(
                  width: double.infinity,
                  height: 137,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const CustomShimmerLine(width: 105, height: 20),
            ),
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Column(
              children: const [
                CustomShimmerLine(
                  width: double.infinity,
                  height: 245,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const CustomShimmerLine(width: 105, height: 20),
            ),
          ),
          const SizedBox(height: 14),
          Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor,
            highlightColor: Colors.white,
            child: Column(
              children: const [
                CustomShimmerLine(
                  width: double.infinity,
                  height: 245,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

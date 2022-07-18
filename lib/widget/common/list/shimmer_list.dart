import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class CustomShimmerList extends StatelessWidget {
  final int length;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final Widget Function(BuildContext context)? separatorBuilder;
  final EdgeInsets? padding;
  final bool reverse;
  final Color? baseColor;
  final Color? highlightColor;
  final bool shrinkWrap;

  const CustomShimmerList({
    Key? key,
    this.length = 5,
    this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.reverse = false,
    this.baseColor,
    this.highlightColor,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      padding: padding,
      reverse: reverse,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => separatorBuilder?.call(context) ?? const CustomDivider(),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: baseColor ?? Theme.of(context).dividerColor,
        highlightColor: highlightColor ?? Colors.white,
        child: itemBuilder?.call(context, index) ??
            CustomListTile(
                title: Row(
                  children: [
                    Container(
                      width: 250,
                      color: Colors.white,
                      child: const Text("test"),
                    ),
                  ],
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        color: Colors.white,
                        child: const Text("test"),
                      ),
                    ],
                  ),
                )),
      ),
      itemCount: length,
    );
  }
}

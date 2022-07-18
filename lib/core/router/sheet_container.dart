import 'package:flutter/material.dart';

const double kPreviousPageVisibleOffset = 10;
const Radius kDefaultTopRadius = Radius.circular(12);
const BoxShadow kDefaultBoxShadow = BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5);

class CupertinoBottomSheetContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Radius? topRadius;
  final BoxShadow? shadow;

  const CupertinoBottomSheetContainer({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.topRadius,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topSafeAreaPadding = MediaQuery.of(context).padding.top;
    final topPadding = kPreviousPageVisibleOffset + topSafeAreaPadding;

    final currentRadius = topRadius ?? kDefaultTopRadius;
    final currentShadow = shadow ?? kDefaultBoxShadow;
    final currentBackgroundColor = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: currentRadius),
        child: Container(
          decoration: BoxDecoration(
            color: currentBackgroundColor,
            boxShadow: [currentShadow],
          ),
          width: double.infinity,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true, //Remove top Safe Area
            child: child,
          ),
        ),
      ),
    );
  }
}

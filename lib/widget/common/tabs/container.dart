import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/tabs/tab.dart';

class CustomTabContainer extends StatefulWidget {
  final int selected;
  final int length;
  final String Function(int index)? textBuilder;
  final Widget Function(BuildContext context, int index)? childBuilder;
  final MainAxisSize mainAxisSize;
  final Widget Function(BuildContext context) contentBuilder;
  final Function(int index)? onTabPressed;
  final EdgeInsets padding;
  final double fadingEdgeSize;
  final Color? fadingEdgeColor;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const CustomTabContainer({
    Key? key,
    this.fadingEdgeColor,
    this.fadingEdgeSize = 0,
    this.selected = 0,
    required this.length,
    required this.contentBuilder,
    this.textBuilder,
    this.childBuilder,
    this.mainAxisSize = MainAxisSize.min,
    this.onTabPressed,
    this.padding = EdgeInsets.zero,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  State<CustomTabContainer> createState() => _CustomTabContainerState();
}

class _CustomTabContainerState extends State<CustomTabContainer> {
  bool _reversed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(CustomTabContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selected != oldWidget.selected) {
      setState(() {
        _reversed = widget.selected < oldWidget.selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisSize: widget.mainAxisSize,
      children: [
        CustomFadingEdgeList(
          direction: Axis.horizontal,
          size: widget.fadingEdgeSize,
          color: widget.fadingEdgeColor ?? Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            padding: widget.padding,
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 4,
              runSpacing: 4,
              children: [
                for (int i = 0; i < widget.length; i++)
                  CustomTab(
                    text: widget.textBuilder?.call(i) ?? "",
                    onPressed: widget.onTabPressed == null
                        ? null
                        : () {
                            if (widget.selected == i) return;
                            widget.onTabPressed?.call(i);
                          },
                    selected: widget.selected == i,
                    child: widget.childBuilder?.call(context, i),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PageTransitionSwitcher(
            reverse: _reversed,
            transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            ),
            child: widget.contentBuilder(context),
          ),
        ),
      ],
    );
  }
}

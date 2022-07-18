import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/tabs/tab.dart';

class CustomTabs extends StatelessWidget {
  final List<String> tabs;
  final int selected;
  final Function(int index) onChanged;
  final Color? color;
  final EdgeInsets padding;

  const CustomTabs({
    Key? key,
    required this.tabs,
    required this.selected,
    required this.onChanged,
    this.color,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color ?? Colors.transparent,
      height: 60.0,
      child: SingleChildScrollView(
        padding: padding,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < (tabs).length; i++)
              CustomTab(
                text: tabs[i],
                selected: selected == i,
                onPressed: () => onChanged.call(i),
              ),
          ],
        ),
      ),
    );
  }
}

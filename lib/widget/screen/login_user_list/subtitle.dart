import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ScreenLoginUserListSubtitle extends StatelessWidget {
  final String text;
  final EdgeInsets? margin;

  const ScreenLoginUserListSubtitle({Key? key, this.text = "", this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CustomListTile(
        titleText: text,
        titleColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

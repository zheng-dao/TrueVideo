import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';

class ScreenLoginUserListEmpty extends StatelessWidget {
  final bool filtering;

  const ScreenLoginUserListEmpty({Key? key, this.filtering = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        const Icon(Icons.people, size: 50),
        Text(
          "No users found",
          style: Theme.of(context).textTheme.headline6,
        ),
        CustomAnimatedCollapseVisibility(
          visible: filtering,
          child: const Text("Try another filter"),
        ),
      ],
    );
  }
}

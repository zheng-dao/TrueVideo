import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

class ScreenNotFound extends StatefulWidget {
  static const String routeName = "/ScreenNotFound";

  const ScreenNotFound({Key? key}) : super(key: key);

  @override
  State<ScreenNotFound> createState() => _ScreenNotFoundState();
}

class _ScreenNotFoundState extends State<ScreenNotFound> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "404",
              style: Theme.of(context).textTheme.headline6,
            ),
            const Text("Page not found"),
          ],
        ),
      ),
    );
  }
}

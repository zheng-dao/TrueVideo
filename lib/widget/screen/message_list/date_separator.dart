import 'package:flutter/material.dart';

class ScreenMessageListTitle extends StatelessWidget {
  final String text;

  const ScreenMessageListTitle({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}

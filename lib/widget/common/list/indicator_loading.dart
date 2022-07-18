import 'package:flutter/material.dart';

class CustomListIndicatorLoading extends StatelessWidget {
  const CustomListIndicatorLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
      ],
    );
  }
}

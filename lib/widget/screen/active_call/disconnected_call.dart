import 'package:flutter/material.dart';

class DisconnectedCall extends StatelessWidget {
  const DisconnectedCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Call disconnected",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

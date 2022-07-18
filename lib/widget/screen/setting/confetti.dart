import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ScreenSettingsConfetti extends StatelessWidget {
  final ConfettiController controller;

  const ScreenSettingsConfetti({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Transform.translate(
              offset: const Offset(-20, -20),
              child: ConfettiWidget(
                confettiController: controller,
                blastDirection: 0.785398,
                emissionFrequency: 0.6,
                gravity: 0.3,
                shouldLoop: false,
                maxBlastForce: 10,
                minBlastForce: 9,
                numberOfParticles: 1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: const Offset(20, -20),
              child: ConfettiWidget(
                confettiController: controller,
                blastDirection: 1.5708,
                emissionFrequency: 0.6,
                gravity: 0.3,
                shouldLoop: false,
                maxBlastForce: 10,
                minBlastForce: 9,
                numberOfParticles: 1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: const Offset(20, -20),
              child: ConfettiWidget(
                confettiController: controller,
                blastDirection: 2.35619,
                emissionFrequency: 0.6,
                gravity: 0.3,
                shouldLoop: false,
                maxBlastForce: 10,
                minBlastForce: 9,
                numberOfParticles: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

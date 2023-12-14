import 'package:flutter/material.dart';

class ColorMixEffectSweep extends StatelessWidget {
  const ColorMixEffectSweep({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const SweepGradient(
          colors: <Color>[Colors.white, Colors.red],
        ).createShader(bounds);
      },
      child: Image.asset(
        'assets/images/2.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}

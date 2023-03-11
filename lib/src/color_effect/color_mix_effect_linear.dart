import 'package:flutter/material.dart';

class ColorMixEffectLinear extends StatelessWidget {
  const ColorMixEffectLinear({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.blue, Colors.green],
        ).createShader(bounds);
      },
      blendMode: BlendMode.color,
      child: Image.asset(
        'assets/images/2.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}

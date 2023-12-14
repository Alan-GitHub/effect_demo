import 'package:flutter/material.dart';

class ColorMixEffectText extends StatelessWidget {
  const ColorMixEffectText({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[Colors.red, Colors.green],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: const Center(
        child: Text(
          '老孟，一枚有态度的程序员',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

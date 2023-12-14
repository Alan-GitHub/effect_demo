import 'package:flutter/material.dart';

class ColorMixEffectRadial extends StatelessWidget {
  const ColorMixEffectRadial({super.key});

  @override
  Widget build(BuildContext context) {
    // return ShaderMask(
    //   shaderCallback: (Rect bounds) {
    //     return const RadialGradient(
    //       radius: 0.5,
    //       colors: <Color>[Colors.red, Colors.green],
    //     ).createShader(bounds);
    //   },
    //   blendMode: BlendMode.color,
    //   child: Image.asset(
    //     'assets/images/2.jpeg',
    //     fit: BoxFit.cover,
    //   ),
    // );

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          radius: .6,
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Colors.grey.withOpacity(.7),
            Colors.grey.withOpacity(.7)
          ],
          stops: const [0, .5, .5, 1],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Image.asset(
        'assets/images/2.jpeg',
        fit: BoxFit.cover,
      ),
    );
  }
}

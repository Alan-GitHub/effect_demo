import 'package:effect_demo/src/constant/RCColors.dart';
import 'package:flutter/material.dart';

class AnimationUsePageV1 extends StatefulWidget {
  const AnimationUsePageV1({super.key});

  @override
  State<AnimationUsePageV1> createState() => _AnimationUsePageV1State();
}

class _AnimationUsePageV1State extends State<AnimationUsePageV1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: ShakeCurve());
    _animation = Tween<double>(begin: 0, end: 300).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: _animation);
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({super.key, required Animation<double> animation}) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ColoredBox(
      color: RCColors.white,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => t * t;
}

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
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear)
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

  static final _opacityTween = Tween<double>(begin: 0.0, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return ColoredBox(
      color: RCColors.white,
      child: Center(
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: const FlutterLogo(),
          ),
        ),
      ),
    );
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => t * t;
}

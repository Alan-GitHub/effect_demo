/*
*
* ```
*
* 以下是一个示例Flutter代码，使用CustomPaint和CustomPainter来创建一个矩形并沿着其边框顺时针移动一束光：

这个代码会创建一个`MovingLight` widget，它会显示一个矩形及一束沿着矩形边框顺时针移动的光。可以将这个widget加入到任何需要的位置。

*
* */

import 'dart:math';

import 'package:flutter/material.dart';

class MovingLight extends StatefulWidget {
  const MovingLight({super.key});

  @override
  State<MovingLight> createState() => _MovingLightState();
}

class _MovingLightState extends State<MovingLight> with TickerProviderStateMixin {
  late AnimationController _controller;
  double _fraction = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _controller.addListener(() {
      setState(() {
        _fraction = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LightPainter(_fraction),
      child: const SizedBox(
        width: 200,
        height: 100,
      ),
    );
  }
}

class LightPainter extends CustomPainter {
  final double fraction;

  LightPainter(this.fraction);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = Colors.grey[400]!;

    canvas.drawRect(rect, paint);

    final lightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0
      ..color = Colors.yellowAccent;

    final path = Path();
    final angle = 2 * pi * fraction;
    final startPoint = rect.topLeft + Offset(0.0, rect.height * 0.25);
    final endPoint = rect.bottomRight - Offset(rect.width * 0.25, 0.0);
    final controlPoint1 = rect.topLeft + Offset(rect.width * 0.5, rect.height * 0.5);
    final controlPoint2 = rect.bottomRight - Offset(rect.width * 0.5, rect.height * 0.5);
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(
      controlPoint1.dx + rect.width * 0.2 * sin(angle),
      controlPoint1.dy + rect.height * 0.2 * cos(angle),
      controlPoint2.dx + rect.width * 0.2 * sin(angle),
      controlPoint2.dy + rect.height * 0.2 * cos(angle),
      endPoint.dx,
      endPoint.dy,
    );

    canvas.drawPath(path, lightPaint);
  }

  @override
  bool shouldRepaint(LightPainter oldDelegate) => oldDelegate.fraction != fraction;
}

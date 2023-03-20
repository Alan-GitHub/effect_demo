import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'joystick_use_page.dart';

class JoystickComponent extends CustomPainter {
  JoystickComponent({
    this.bigCircleImage,
    this.littleCircleImage,
    this.bigCircleR = 0,
    this.littleCircleR = 0,
    required this.joystickData,
  }) : super(repaint: joystickData);

  final ui.Image? bigCircleImage;
  final ui.Image? littleCircleImage;
  final double bigCircleR;
  final double littleCircleR;
  final ValueNotifier<JoystickData> joystickData;

  @override
  void paint(Canvas canvas, Size size) {
    // double bgR = 50;

    // 底圆
    // canvas.drawCircle(
    //     const Offset(0, 0),
    //     bgR,
    //     paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.2));

    // 手势小圆
    // canvas.drawCircle(
    //     const Offset(0, 0),
    //     bgR / 2,
    //     paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.9));

    //大圆原点坐标
    double bigCircleOriginDx = joystickData.value.offset.dx - bigCircleR;
    double bigCircleOriginDy = joystickData.value.offset.dy - bigCircleR;

    //大圆边界处理
    if (bigCircleOriginDx < 0) {
      bigCircleOriginDx = 0;
    }

    if (bigCircleOriginDx > size.width - 2 * bigCircleR) {
      bigCircleOriginDx = size.width - 2 * bigCircleR;
    }

    if (bigCircleOriginDy < 0) {
      bigCircleOriginDy = 0;
    }

    if (bigCircleOriginDy > size.height - 2 * bigCircleR) {
      bigCircleOriginDy = size.height - 2 * bigCircleR;
    }

    //小圆原点坐标
    double littleCircleOriginDx = bigCircleOriginDx + (bigCircleR - littleCircleR);
    double littleCircleOriginDy = bigCircleOriginDy + (bigCircleR - littleCircleR);

    Paint paint = Paint();

    if (bigCircleImage != null) {
      canvas.drawImage(bigCircleImage!, Offset(bigCircleOriginDx, bigCircleOriginDy), paint);
    }

    if (littleCircleImage != null) {
      canvas.drawImage(littleCircleImage!, Offset(littleCircleOriginDx, littleCircleOriginDy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'dart:math';

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

  late double bigCircleOriginDx;
  late double bigCircleOriginDy;
  late double littleCircleOriginDx;
  late double littleCircleOriginDy;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    if (joystickData.value.panDetail is DragDownDetails) {
      paintDown(canvas, size, paint);
    } else if (joystickData.value.panDetail is DragEndDetails) {
      paintReset(canvas, paint);
    } else if (joystickData.value.panDetail is DragUpdateDetails) {
      paintUpdate(canvas, paint);
    }
  }

  // 绘制手指按下时图形
  void paintDown(Canvas canvas, Size size, Paint paint) {
    //大圆原点坐标
    bigCircleOriginDx = joystickData.value.offset.dx - bigCircleR;
    bigCircleOriginDy = joystickData.value.offset.dy - bigCircleR;

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
    littleCircleOriginDx = bigCircleOriginDx + (bigCircleR - littleCircleR);
    littleCircleOriginDy = bigCircleOriginDy + (bigCircleR - littleCircleR);

    if (bigCircleImage != null) {
      canvas.drawImage(bigCircleImage!, Offset(bigCircleOriginDx, bigCircleOriginDy), paint);
    }

    if (littleCircleImage != null) {
      canvas.drawImage(littleCircleImage!, Offset(littleCircleOriginDx, littleCircleOriginDy), paint);
    }
  }

  void paintUpdate(Canvas canvas, Paint paint) {
    if (bigCircleImage != null) {
      canvas.drawImage(bigCircleImage!, Offset(bigCircleOriginDx, bigCircleOriginDy), paint);
    }

    DragUpdateDetails update = joystickData.value.panDetail as DragUpdateDetails;

    littleCircleOriginDx += update.delta.dx;
    littleCircleOriginDy += update.delta.dy;

    // 小圆心坐标
    double littleCircleCenterDx = littleCircleOriginDx + littleCircleR;
    double littleCircleCenterDy = littleCircleOriginDy + littleCircleR;

    // 大圆圆心
    double bigCircleCenterDx = bigCircleOriginDx + bigCircleR;
    double bigCircleCenterDy = bigCircleOriginDy + bigCircleR;

    // 两个圆心相对坐标，以底圆心为原点
    double rx = littleCircleCenterDx - bigCircleCenterDx;
    double ry = -(littleCircleCenterDy - bigCircleCenterDy);

    // 手指接触点离底圆圆心的距离
    double distance = sqrt(pow(rx, 2) + pow(ry, 2));
    // 角度
    double thta = atan2(ry, rx);


    if (distance > bigCircleR) {
      littleCircleCenterDx = bigCircleR * cos(thta) + bigCircleCenterDx;
      littleCircleCenterDy = bigCircleR * sin(thta) + bigCircleCenterDy;
    }

    // 小圆左上角在坐标系中的坐标
    littleCircleOriginDx = littleCircleCenterDx - littleCircleR;
    littleCircleOriginDy = littleCircleCenterDy - littleCircleR;

    if (littleCircleImage != null) {
      canvas.drawImage(littleCircleImage!, Offset(littleCircleOriginDx, littleCircleOriginDy), paint);
    }
  }

  void paintReset(Canvas canvas, Paint paint) {
    //大圆原点坐标
    bigCircleOriginDx = joystickData.value.offset.dx - bigCircleR;
    bigCircleOriginDy = joystickData.value.offset.dy - bigCircleR;

    //小圆原点坐标
    littleCircleOriginDx = bigCircleOriginDx + (bigCircleR - littleCircleR);
    littleCircleOriginDy = bigCircleOriginDy + (bigCircleR - littleCircleR);

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

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class JoyStick extends StatefulWidget {
  const JoyStick({
    Key? key,
    required this.size,
    this.bigCircleImage,
    this.littleCircleImage,
    required this.bgR,
    required this.bgr,
  }) : super(key: key);

  final Size size;
  final ui.Image? bigCircleImage;
  final ui.Image? littleCircleImage;
  final double bgR; // 底圆半径
  final double bgr; // 小圆半径

  @override
  State<JoyStick> createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  // 底图圆心坐标
  final ValueNotifier<Offset> _offsetCenter = ValueNotifier(Offset.zero);
  // 小圆圆心坐标
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: down,
      onPanUpdate: update,
      onPanEnd: reset,
      child: CustomPaint(
        size: widget.size,
        painter: JoyStickPainter(
            offset: _offset,
            bgr: widget.bgr,
            offsetCenter: _offsetCenter,
            bgR: widget.bgR,
            bigCircleImage: widget.bigCircleImage,
            littleCircleImage: widget.littleCircleImage,
            listenable: Listenable.merge([_offset, _offsetCenter])),
      ),
    );
  }

  down(DragDownDetails details) {
    Offset offset = details.localPosition;

    if (offset.dx > widget.size.width - widget.bgR) {
      offset = Offset(widget.size.width - widget.bgR, offset.dy);
    }
    if (offset.dx < widget.bgR) {
      offset = Offset(widget.bgR, offset.dy);
    }
    if (offset.dy > widget.size.height - widget.bgR) {
      offset = Offset(offset.dx, widget.size.height - widget.bgR);
    }
    if (offset.dy < widget.bgR) {
      offset = Offset(offset.dx, widget.bgR);
    }
    _offsetCenter.value = offset.translate(-widget.size.width / 2, -widget.size.height / 2);
    _offset.value = offset.translate(-widget.size.width / 2, -widget.size.height / 2);
  }

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
    _offsetCenter.value = Offset.zero;
  }

  update(DragUpdateDetails details) {
    final offset = details.localPosition;
    _offset.value = Offset(offset.dx, offset.dy).translate(-widget.size.width / 2, -widget.size.height / 2);
  }
}

class JoyStickPainter extends CustomPainter {
  JoyStickPainter({
    required this.offset,
    required this.bgr,
    required this.offsetCenter,
    required this.bgR,
    this.bigCircleImage,
    this.littleCircleImage,
    required Listenable listenable,
  }) : super(repaint: listenable) {
    _paint = Paint();
  }

  final ValueNotifier<Offset> offset;
  final double bgr;
  final ValueNotifier<Offset> offsetCenter;
  late double bgR; // 底圆半径
  final ui.Image? bigCircleImage;
  final ui.Image? littleCircleImage;

  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    /// 手指移动坐标
    var offsetTranslate = offset.value;

    /// 操纵杆圆心坐标
    var offsetTranslateCenter = offsetCenter.value;

    /// 计算当前位置坐标点 左半区域 X为负数
    double x = offsetTranslateCenter.dx - offsetTranslate.dx;

    /// y轴 下半区域 Y为负数
    double y = offsetTranslateCenter.dy - offsetTranslate.dy;

    /// 反正切函数 通过此函数可以计算出此坐标旋转的弧度 为正 代表X轴逆时针旋转的角度 为负 顺时针旋转角度
    /// 范围 [-pi] - [pi]
    double ata = atan2(y, x);
    // print(
    //     "downCenter dx ${offsetTranslateCenter.dx} down dy ${offsetTranslateCenter.dy}");
    // print("down dx $x down dy $y");
    /// 默认坐标系范围为-pi - pi  顺时针旋转坐标系180度 变为 0 - 2*pi;
    var thta = ata + pi;
    // print("angle ${(180 / pi * ata).toInt()}");

    // print("angle $thta");
    // print("angle $ata");
    /// 半径长度
    var r = sqrt(pow(x, 2) + pow(y, 2));
    if (r > bgR) {
      var dx = bgR * cos(thta) + offsetTranslateCenter.dx; // 求边长 cos
      var dy = bgR * sin(thta) + offsetTranslateCenter.dy; // 求边长
      offsetTranslate = Offset(dx, dy);
    }

    // 底圆
    // canvas.drawCircle(
    //     offsetTranslateCenter,
    //     bgR,
    //     _paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.2));
    canvas.drawImage(bigCircleImage!, offsetTranslateCenter.translate(-bgR, -bgR), _paint);

    /// 手势小圆
    // canvas.drawCircle(
    //     offsetTranslate,
    //     bgr,
    //     _paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.6));
    canvas.drawImage(littleCircleImage!, offsetTranslate.translate(-bgr, -bgr), _paint);
  }

  @override
  bool shouldRepaint(covariant JoyStickPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.offsetCenter != offsetCenter;
  }
}

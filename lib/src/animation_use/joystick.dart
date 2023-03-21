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
    var offsetCenterTranslate = offsetCenter.value;

    /// 计算当前位置坐标点 左半区域 X为负数
    double x = offsetTranslate.dx - offsetCenterTranslate.dx;

    /// y轴 下半区域 Y为正数   坐标轴水平往右，垂直向下为正
    double y = offsetTranslate.dy - offsetCenterTranslate.dy;

    // print(
    //     "downCenter dx ${offsetTranslateCenter.dx} down dy ${offsetTranslateCenter.dy}");
    // print("down dx $x down dy $y");

    /// 反正切函数 通过此函数可以计算出此坐标旋转的弧度 即方位角（原点至该点的方位角，即该点与 x 轴的夹角）
    /// 传统坐标轴上（X轴向右、Y轴向上为正），X轴逆时针旋转为正，顺时针旋转为负。 范围 （-pi，pi]
    /// 计算机中，因为坐标轴的Y轴反向（X轴向右、Y轴向下为正） X轴逆时针旋转为负，顺时针旋转为正。 范围 （-pi，pi]。
    /// 计算机中的坐标轴可理解为传统坐标轴沿着X轴翻转而来
    double ata = atan2(y, x);

    /// 默认坐标系范围为-pi - pi  顺时针旋转坐标系180度 变为 0 - 2*pi;
    // print("angle ${(180 / pi * ata).toInt()}");
    // print("angle $ata");

    /// 半径长度
    var r = sqrt(pow(x, 2) + pow(y, 2));
    if (r > bgR) {
      var dx = bgR * cos(ata) + offsetCenterTranslate.dx; // 求边长 cos
      var dy = bgR * sin(ata) + offsetCenterTranslate.dy; // 求边长
      offsetTranslate = Offset(dx, dy);
    }

    // 底圆
    // canvas.drawCircle(
    //     offsetCenterTranslate,
    //     bgR,
    //     _paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.2));
    canvas.drawImage(bigCircleImage!, offsetCenterTranslate.translate(-bgR, -bgR), _paint);

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

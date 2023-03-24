import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

enum PanStatus {
  down,
  update,
  end,
}

class JoyStick extends StatefulWidget {
  const JoyStick({
    Key? key,
    required this.size,
    this.bigCircleImage,
    this.littleCircleImage,
    this.bigCircleImageSport,
    this.littleCircleImageSport,
    required this.bgR,
    required this.bgr,
    this.thresholdArc = 0,
    this.deadZoneArc = 0,
    required this.onMove,
  }) : super(key: key);

  final Size size;
  final ui.Image? bigCircleImage;
  final ui.Image? littleCircleImage;
  final ui.Image? bigCircleImageSport;
  final ui.Image? littleCircleImageSport;
  final double bgR; // 底圆半径
  final double bgr; // 小圆半径
  final double thresholdArc;
  final double deadZoneArc;
  final void Function(double arc, double dx, double dy, double r) onMove;

  @override
  State<JoyStick> createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  // 底图圆心坐标
  final ValueNotifier<Offset> _offsetCenter = ValueNotifier(Offset.zero);
  // 小圆圆心坐标
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  ValueNotifier<PanStatus> status = ValueNotifier(PanStatus.end);

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
            bigCircleImageSport: widget.bigCircleImageSport,
            littleCircleImageSport: widget.littleCircleImageSport,
            thresholdArc: widget.thresholdArc,
            deadZoneArc: widget.deadZoneArc,
            status: status,
            onMove: widget.onMove,
            listenable: Listenable.merge([_offset, _offsetCenter])),
      ),
    );
  }

  down(DragDownDetails details) {
    status.value = PanStatus.down;
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
    status.value = PanStatus.end;
    _offset.value = Offset.zero;
    _offsetCenter.value = Offset.zero;
  }

  update(DragUpdateDetails details) {
    status.value = PanStatus.update;
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
    this.bigCircleImageSport,
    this.littleCircleImageSport,
    required this.thresholdArc,
    required this.deadZoneArc,
    required this.status,
    required this.onMove,
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
  final ui.Image? bigCircleImageSport;
  final ui.Image? littleCircleImageSport;

  /// 弧度阈值-禁止区域的角度的一半，弧度表示
  final double thresholdArc;

  /// 死区阈值 - 处于禁止区内，越过死区阈值即调整小球位置，弧度表示
  final double deadZoneArc;

  final ValueNotifier<PanStatus> status;

  final void Function(double arc, double dx, double dy, double r) onMove;

  late Paint _paint;

  /// 有效弧度， 因为底圆可能有禁止滑动区，所以弧度范围非完整圆
  double _effectiveArc = 0;

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

    /// 反正切函数 通过此函数可以计算出此坐标旋转的弧度 即方位角（原点至该点的方位角，即该点与 x 轴的夹角）
    /// 传统坐标轴上（X轴向右、Y轴向上为正），X轴逆时针旋转为正，顺时针旋转为负。 范围 （-pi，pi]
    /// 计算机中，因为坐标轴的Y轴反向（X轴向右、Y轴向下为正） X轴逆时针旋转为负，顺时针旋转为正。 范围 （-pi，pi]。
    /// 计算机中的坐标轴可理解为传统坐标轴沿着X轴翻转而来
    double ata = atan2(y, x);

    /// 默认坐标系范围为-pi - pi  顺时针旋转坐标系180度 变为 0 - 2*pi;
    // print("ata ${(180 / pi * ata).toInt()}");

    /// 半径长度
    var r = sqrt(pow(x, 2) + pow(y, 2));

    /// 限定小球在底圆内运动
    if (r > bgR) {
      var dx = bgR * cos(ata) + offsetCenterTranslate.dx; // 求边长 cos
      var dy = bgR * sin(ata) + offsetCenterTranslate.dy; // 求边长
      offsetTranslate = Offset(dx, dy);

      r = bgR;
    }

    /// 限定小球在底圆指定范围内运动
    if (ata.abs() < thresholdArc.abs()) {
      if (ata > deadZoneArc) {
        _effectiveArc = thresholdArc;
      } else if (ata < -deadZoneArc) {
        _effectiveArc = -thresholdArc;
      }

      if (_effectiveArc.abs() != thresholdArc && ata >= -deadZoneArc && ata <= deadZoneArc) {
        offsetTranslate = offsetCenterTranslate;
      } else {
        var dx = r * cos(_effectiveArc) + offsetCenterTranslate.dx; // 求边长 cos
        var dy = r * sin(_effectiveArc) + offsetCenterTranslate.dy; // 求边长
        offsetTranslate = Offset(dx, dy);
      }
    } else if (ata.abs() > (pi - thresholdArc)) {
      if (ata > 0 && ata < pi - deadZoneArc) {
        _effectiveArc = pi - thresholdArc;
      } else if (ata < 0 && ata > -(pi - deadZoneArc)) {
        _effectiveArc = -(pi - thresholdArc);
      }

      if ((_effectiveArc.abs() != pi - thresholdArc) && (ata.abs() >= (pi - deadZoneArc))) {
        offsetTranslate = offsetCenterTranslate;
      } else {
        var dx = r * cos(_effectiveArc) + offsetCenterTranslate.dx; // 求边长 cos
        var dy = r * sin(_effectiveArc) + offsetCenterTranslate.dy; // 求边长
        offsetTranslate = Offset(dx, dy);
      }
    } else {
      _effectiveArc = ata;
    }

    /// 回调通知上层移动的数据
    onMove(r == 0 ? 0 : _effectiveArc, offsetTranslate.dx - offsetCenterTranslate.dx,
        offsetTranslate.dy - offsetCenterTranslate.dy, r);

    if (status.value == PanStatus.end) {
      /// 底圆
      if (bigCircleImage != null) {
        canvas.drawImage(bigCircleImage!, offsetCenterTranslate.translate(-bgR, -bgR), _paint);
      } else {
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.2);
        canvas.drawCircle(offsetCenterTranslate, bgR, _paint);
      }

      /// 手势小圆
      if (littleCircleImage != null) {
        canvas.drawImage(littleCircleImage!, offsetTranslate.translate(-bgr, -bgr), _paint);
      } else {
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.6);
        canvas.drawCircle(offsetTranslate, bgr, _paint);
      }
    } else {
      /// 底圆
      if (bigCircleImageSport != null) {
        canvas.drawImage(bigCircleImageSport!, offsetCenterTranslate.translate(-bgR, -bgR), _paint);
      } else if (bigCircleImage != null) {
        canvas.drawImage(bigCircleImage!, offsetCenterTranslate.translate(-bgR, -bgR), _paint);
      } else {
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.2);
        canvas.drawCircle(offsetCenterTranslate, bgR, _paint);
      }

      /// 手势小圆
      if (littleCircleImageSport != null) {
        canvas.drawImage(littleCircleImageSport!, offsetTranslate.translate(-bgr, -bgr), _paint);
      } else if (littleCircleImage != null) {
        canvas.drawImage(littleCircleImage!, offsetTranslate.translate(-bgr, -bgr), _paint);
      } else {
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.6);
        canvas.drawCircle(offsetTranslate, bgr, _paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant JoyStickPainter oldDelegate) {
    return oldDelegate.offset != offset || oldDelegate.offsetCenter != offsetCenter;
  }
}

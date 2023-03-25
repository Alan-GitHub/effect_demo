import 'dart:math';

import 'package:effect_demo/src/constant/RCColors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

enum VerticalDragStatus {
  down,
  update,
  end,
}

class VerticalJoyStick extends StatefulWidget {
  const VerticalJoyStick({
    super.key,
    required this.size,
    this.rRectRadius = 0,
    required this.radius,
    required this.onMove,
  });

  final Size size;
  final double rRectRadius;
  final double radius;
  final void Function(double dy) onMove;

  @override
  State<VerticalJoyStick> createState() => _VerticalJoyStickState();
}

class _VerticalJoyStickState extends State<VerticalJoyStick> {
  // 小圆圆心坐标
  late final ValueNotifier<Offset> _offset;
  // 操纵杆状态
  ValueNotifier<VerticalDragStatus> status = ValueNotifier(VerticalDragStatus.end);

  @override
  void initState() {
    super.initState();

    _offset = ValueNotifier(Offset(widget.size.width / 2, widget.size.height / 2));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: down,
      onVerticalDragUpdate: update,
      onVerticalDragEnd: end,
      child: CustomPaint(
        size: widget.size,
        painter: VerticalJoyStickPainter(
          rRectRadius: widget.rRectRadius,
          offset: _offset,
          radius: widget.radius,
          status: status,
          onMove: widget.onMove,
          listenable: _offset,
        ),
      ),
    );
  }

  down(DragDownDetails details) {
    status.value = VerticalDragStatus.down;

    double rx = widget.size.width / 2;
    double ry = details.localPosition.dy;

    if (ry < widget.radius) {
      ry = widget.radius;
    } else if (ry > widget.size.height - widget.radius) {
      ry = widget.size.height - widget.radius;
    }

    _offset.value = Offset(rx, ry);
  }

  update(DragUpdateDetails details) {
    status.value = VerticalDragStatus.update;

    double rx = widget.size.width / 2;
    double ry = details.localPosition.dy;

    if (ry < widget.radius) {
      ry = widget.radius;
    } else if (ry > widget.size.height - widget.radius) {
      ry = widget.size.height - widget.radius;
    }

    _offset.value = Offset(rx, ry);
  }

  end(DragEndDetails details) {
    status.value = VerticalDragStatus.end;

    _offset.value = Offset(widget.size.width / 2, widget.size.height / 2);
  }
}

class VerticalJoyStickPainter extends CustomPainter {
  VerticalJoyStickPainter({
    this.rRectRadius = 0,
    required this.offset,
    required this.radius,
    required this.status,
    required this.onMove,
    required Listenable listenable,
  }) : super(repaint: listenable);

  /// 底圆矩形的圆角半径
  final double rRectRadius;

  /// 控制球圆心
  final ValueNotifier<Offset> offset;

  /// 控制球半径
  final double radius;

  /// 手势状态
  final ValueNotifier<VerticalDragStatus> status;

  final void Function(double dy) onMove;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    /// 计算控制球圆心相对底图矩形中心的y坐标
    double dy = offset.value.dy - size.height / 2;

    /// 回调通知上层移动的数据 - y坐标
    onMove(dy);

    /// 底图描边
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = RCColors.gray_5F7176.withOpacity(0.3);
    canvas.drawRRect(RRect.fromRectXY(rect, rRectRadius, rRectRadius), _paint);

    /// 绘制底图圆角矩形
    _paint
      ..style = PaintingStyle.fill
      ..color = RCColors.gray_0A1014.withOpacity(0.3);
    canvas.drawRRect(RRect.fromRectXY(rect, rRectRadius, rRectRadius), _paint);

    /// 计算控制球在可移动范围内的滑动比值，滑动越多，相应端的指示颜色越深
    double ratio = dy.abs() / (size.height / 2.0 - radius);
    if (dy < 0) {
      _paint.color = RCColors.gray_0A1014;
      _paint.shader = ui.Gradient.linear(Offset(size.width / 2, 0), Offset(size.width / 2, size.width / 2),
          [RCColors.blue_2FD9F8.withOpacity(ratio), RCColors.transparent]);
      canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.width), pi, pi, false, _paint);
      _paint.shader = null;
    } else if (dy > 0) {
      _paint.color = RCColors.gray_0A1014;
      _paint.shader = ui.Gradient.linear(Offset(size.width / 2, size.height - size.width / 2),
          Offset(size.width / 2, size.height), [RCColors.transparent, RCColors.blue_2FD9F8.withOpacity(ratio)]);
      canvas.drawArc(Rect.fromLTWH(0, size.height - size.width, size.width, size.width), 0, pi, false, _paint);
      _paint.shader = null;
    }

    /// 绘制控制小球球
    _paint
      ..style = PaintingStyle.fill
      ..color = RCColors.black_171E22.withOpacity(0.7);
    canvas.drawCircle(offset.value, radius, _paint);

    /// 控制小球球描边
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = RCColors.white;
    if (status.value != VerticalDragStatus.end) {
      _paint.color = RCColors.blue_2FD9F8;
    }
    canvas.drawCircle(offset.value, radius, _paint);

    /// 小球球里面的三角形（上）
    /// 小球球圆心坐标
    double rx = offset.value.dx;
    double ry = offset.value.dy;

    _paint
      ..style = PaintingStyle.fill
      ..color = RCColors.white;

    /// 适配屏幕时的缩放比例
    double scale = radius / 24;

    if (dy < 0) {
      _paint.color = RCColors.blue_2FD9F8;
    }

    var path1 = Path();
    path1.moveTo(rx - 6 * scale, ry - 3 * scale);
    path1.lineTo(rx, ry - 11 * scale);
    path1.lineTo(rx + 6 * scale, ry - 3 * scale);
    path1.close();

    if (dy < 0) {
      drawShadows(canvas, path1, [const BoxShadow(color: RCColors.blue_2FD9F8, blurRadius: 10, spreadRadius: 12)], -1);
    }
    canvas.drawPath(path1, _paint);

    /// 小球球里面的三角形（下）
    _paint.color = RCColors.white;
    if (dy > 0) {
      _paint.color = RCColors.blue_2FD9F8;
    }

    var path2 = Path();
    path2.moveTo(rx - 6 * scale, ry + 3 * scale);
    path2.lineTo(rx, ry + 11 * scale);
    path2.lineTo(rx + 6 * scale, ry + 3 * scale);
    path2.close();

    if (dy > 0) {
      drawShadows(canvas, path2, [const BoxShadow(color: RCColors.blue_2FD9F8, blurRadius: 10, spreadRadius: 12)], 1);
    }
    canvas.drawPath(path2, _paint);
  }

  @override
  bool shouldRepaint(covariant VerticalJoyStickPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }

  /// 绘制阴影封装函数
  void drawShadows(Canvas canvas, Path path, List<BoxShadow> shadows, double revise) {
    for (final BoxShadow shadow in shadows) {
      final Paint shadowPainter = shadow.toPaint();
      if (shadow.spreadRadius == 0) {
        canvas.drawPath(path.shift(shadow.offset), shadowPainter);
      } else {
        /// 生成一个刚好包住目标path图案的矩形
        Rect zone = path.getBounds();

        /// 阴影传播半径 + 矩形宽高得到缩放比例
        double xScale = (zone.width + shadow.spreadRadius) / zone.width;
        double yScale = (zone.height + shadow.spreadRadius) / zone.height;

        /// 获取单位4x4矩阵
        Matrix4 m4 = Matrix4.identity();

        /// 缩放指定比例。不只图形会变大，矩形中心坐标也会移动对应缩放倍数
        m4.scale(xScale, yScale);

        /// 缩放时，坐标也移动了缩放倍数，需要平移回原始位置
        m4.translate(-zone.center.dx * (xScale - 1.0) / xScale, -zone.center.dy * (yScale - 1.0) / yScale + revise);
        canvas.drawPath(path.shift(shadow.offset).transform(m4.storage), shadowPainter);
      }
    }
  }
}

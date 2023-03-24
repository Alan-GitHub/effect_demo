import 'package:effect_demo/src/constant/RCColors.dart';
import 'package:flutter/material.dart';

class VerticalJoyStick extends StatefulWidget {
  const VerticalJoyStick({
    super.key,
    required this.size,
    this.rRectRadius = 0,
    required this.radius,
  });

  final Size size;
  final double rRectRadius;
  final double radius;

  @override
  State<VerticalJoyStick> createState() => _VerticalJoyStickState();
}

class _VerticalJoyStickState extends State<VerticalJoyStick> {
  // 小圆圆心坐标
  late final ValueNotifier<Offset> _offset;

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
          listenable: _offset,
        ),
      ),
    );
  }

  down(DragDownDetails details) {
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
    _offset.value = Offset(widget.size.width / 2, widget.size.height / 2);
  }
}

class VerticalJoyStickPainter extends CustomPainter {
  VerticalJoyStickPainter({
    this.rRectRadius = 0,
    required this.offset,
    required this.radius,
    required Listenable listenable,
  }) : super(repaint: listenable);

  /// 底圆矩形的圆角半径
  final double rRectRadius;
  final ValueNotifier<Offset> offset;
  final double radius;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    /// 绘制底图圆角矩形
    _paint
      ..style = PaintingStyle.fill
      ..color = RCColors.gray_0A1014.withOpacity(0.3);
    canvas.drawRRect(RRect.fromRectXY(rect, rRectRadius, rRectRadius), _paint);

    /// 底图描边
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = RCColors.gray_5F7176.withOpacity(0.3);
    canvas.drawRRect(RRect.fromRectXY(rect, rRectRadius, rRectRadius), _paint);

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

    var path1 = Path();
    path1.moveTo(rx - 6 * scale, ry - 3 * scale);
    path1.lineTo(rx, ry - 11 * scale);
    path1.lineTo(rx + 6 * scale, ry - 3 * scale);
    path1.close();
    canvas.drawPath(path1, _paint);

    /// 小球球里面的三角形（下）
    var path2 = Path();
    path2.moveTo(rx - 6 * scale, ry + 3 * scale);
    path2.lineTo(rx, ry + 11 * scale);
    path2.lineTo(rx + 6 * scale, ry + 3 * scale);
    path2.close();
    canvas.drawPath(path2, _paint);
  }

  @override
  bool shouldRepaint(covariant VerticalJoyStickPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}

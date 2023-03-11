/*
* ```
* 下面是一个通过Flutter实现的带有边框发光并流动的代码示例：
使用该组件的方法非常简单，只需要在Widget树中引入即可：

```
GlowingBorder(
      width: 12.0,
      glowColor: Colors.blue,
      child: Container(
        width: 200.0,
        height: 100.0,
        color: Colors.white,
      ),
    ),
```

这段代码将生成一个宽度为200、高度为100的白色矩形，边框发出蓝色的发光效果，并且这个发光效果会流动。
*
* */

// 这是一个发光矩形边框自动缩放的效果

import 'package:flutter/material.dart';

class GlowingBorder extends StatefulWidget {
  final Widget child;
  final double width;
  final Color glowColor;

  const GlowingBorder({
    super.key,
    required this.child,
    required this.width,
    required this.glowColor,
  });

  @override
  State<GlowingBorder> createState() => _GlowingBorderState();
}

class _GlowingBorderState extends State<GlowingBorder> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: widget.width).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: widget.glowColor.withOpacity(0.5),
              width: _animation.value,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.8),
                blurRadius: 24.0,
                offset: Offset.fromDirection(0.0, 2.0),
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

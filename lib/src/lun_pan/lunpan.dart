/*

以下是使用Flutter实现王者荣耀游戏中控制英雄前后左右移动的轮盘效果的简单步骤：

1. 创建一个Stack组件，用于叠放各种轮盘组件。

2. 创建一个透明的Container组件，并添加手势检测，捕获用户的触摸事件。在onPanDown回调函数中创建一个圆形轮盘组件，并将其添加到Stack中。

3. 在圆形轮盘组件中，创建四个按钮组件，分别表示向上、向下、向左、向右移动。同时，添加手势检测，捕获用户在按钮组件上的触摸事件，并通过回调函数来执行英雄的移动操作。

4. 在圆形轮盘组件上方添加一个中心点，用于表示英雄的当前位置。

5. 将整体布局进行优化，使其更加美观易用。

以下是实现圆形轮盘组件的代码示例：


```

在整个布局中，只有一个Container组件是可交互的，并且它被设置为透明的。这样用户就可以在容器内自由拖动圆形轮盘组件。所有的按钮组件和中心点都是静态的，
它们在圆形轮盘组件上方叠放而成。

实现圆形轮盘组件之后，在父组件中可以通过回调函数来获取英雄的移动方向，从而实现英雄的移动操作。完整的代码示例可以参考以下链接：

https://github.com/gerardduenas/flutter_joystick

*/

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stick extends StatefulWidget {
  final double size;
  final Function onMove;

  Stick({required this.size, required this.onMove});

  @override
  _StickState createState() => _StickState();
}

class _StickState extends State<Stick> {
  late Offset position;
  late double radius;

  @override
  void initState() {
    super.initState();

    position = Offset.zero;
    radius = widget.size / 2;
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final dx = details.localPosition.dx - radius;
      final dy = details.localPosition.dy - radius;

      final distance = sqrt(dx * dx + dy * dy);

      if (distance <= radius) {
        position = details.localPosition;
      } else {
        position = Offset(dx / distance * radius + radius, dy / distance * radius + radius);
      }
    });

    final dx = position.dx - radius;
    final dy = position.dy - radius;

    final direction = atan2(dy, dx);

    widget.onMove(cos(direction), sin(direction));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.size,
      height: widget.size,
      child: GestureDetector(
        onPanUpdate: onPanUpdate,
        child: Stack(
          children: [
            Positioned(
              left: position.dx - radius / 2,
              top: position.dy - radius / 2,
              child: Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              left: position.dx - radius / 4,
              top: position.dy - radius / 4,
              child: Container(
                width: radius / 2,
                height: radius / 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

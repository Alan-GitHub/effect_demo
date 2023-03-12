/*
*
* ```
下面是用Flutter实现矩形四条边框发微光，有两个对称的发光球体沿着矩形边框一直向前移动的代码：

*
解释：
1. `LightBox`是一个带状态的组件，使用了`SingleTickerProviderStateMixin`来实现动画效果。
2. `AnimationController`用于控制动画的执行，设置了每次执行1秒，并通过`addListener`注册了一个回调，每次执行时更新状态并重新绘制视图。
3. 在`decoration`中设置了矩形的样式，包括边框颜色和宽度。
4. 通过`Stack`布局，在矩形的左上角和右上角分别放置了两个发光的球体，通过`Transform.translate`来实现在边框上沿着矩形移动的效果。
* 球体的样式为圆形和渐变的白色透明度，用于产生发光的效果。

*
* */

import 'package:flutter/material.dart';

class LightBox extends StatefulWidget {
  const LightBox({super.key});

  @override
  State<LightBox> createState() => _LightBoxState();
}

class _LightBoxState extends State<LightBox> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2 + 10 * _animationController.value,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: Offset(0, -100 + 200 * _animationController.value),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(0, -100 + 200 * _animationController.value),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white.withOpacity(0.5),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

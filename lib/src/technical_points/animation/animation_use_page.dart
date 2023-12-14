import 'dart:math';

import 'package:flutter/material.dart';

class AnimationUsePage extends StatefulWidget {
  const AnimationUsePage({super.key});

  @override
  State<AnimationUsePage> createState() => _AnimationUsePageState();
}

class _AnimationUsePageState extends State<AnimationUsePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, lowerBound: 0, upperBound: 2 * pi, duration: const Duration(seconds: 2));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
                alignment: Alignment.center, //相对于坐标系原点的对齐方式
                transform: Matrix4.identity()
                  ..rotateX(_controller.value) //x轴不变
                  ..rotateY(_controller.value), //绕y轴旋转，0-2pi
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.amber,
                  child: child,
                ));
          },
          child: const Text("---->"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: const Text("点我"),
      ),
    );
  }
}

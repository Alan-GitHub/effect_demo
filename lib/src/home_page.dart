import 'package:effect_demo/src/router/RouteTable.dart';
import 'package:effect_demo/src/router/nav.dart';
import 'package:effect_demo/src/technical_points/gesture/gesture_demo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("特效Demo"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.colorEffectPage);
                  },
                  child: const Text("颜色渐变特效"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.expandCollapsePage);
                  },
                  child: const Text("展开收起效果"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.heroAnimationPage);
                  },
                  child: const Text("动画入门"),
                ),
                const GestureDemo(),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.joystickUsePage);
                  },
                  child: const Text("操纵杆"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.verticalJoystickUsePage);
                  },
                  child: const Text("竖直操纵杆"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.circleProgressIndicatorDemo);
                  },
                  child: const Text("圆形进度条"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.imagePickerPage);
                  },
                  child: const Text("拾取图片或视频"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.innerShadowPage);
                  },
                  child: const Text("内阴影"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.contextUI);
                  },
                  child: const Text("上下文UI"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.streamBuilderUsePage);
                  },
                  child: const Text("StreamBuilder使用"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.isolateUsePage);
                  },
                  child: const Text("isolate使用"),
                ),
              ],
            ),
          ),
        ));
  }
}

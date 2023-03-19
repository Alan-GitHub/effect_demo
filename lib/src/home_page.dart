import 'package:effect_demo/src/gesture/gesture_demo.dart';
import 'package:effect_demo/src/lun_pan/lunpan.dart';
import 'package:effect_demo/src/router/RouteTable.dart';
import 'package:effect_demo/src/router/nav.dart';
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
                    Nav.pushName(RouteName.kindaCodeDemo);
                  },
                  child: const Text("轮盘效果"),
                ),
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.animationUsePage);
                  },
                  child: const Text("动画入门"),
                ),
                GestureDemo(),
              ],
            ),
          ),
        ));
  }
}

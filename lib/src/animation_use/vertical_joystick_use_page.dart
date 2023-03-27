import 'package:effect_demo/src/animation_use/vertical_joystick.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class VerticalJoystickUsePage extends StatefulWidget {
  const VerticalJoystickUsePage({super.key});

  @override
  State<VerticalJoystickUsePage> createState() => _VerticalJoystickUsePageState();
}

class _VerticalJoystickUsePageState extends State<VerticalJoystickUsePage> {
  ui.Image? driveVerticalOutline;
  ui.Image? driveVerticalControlStop;
  ui.Image? driveVerticalControlUp;
  ui.Image? driveVerticalControlDown;

  @override
  void initState() {
    super.initState();

    Future.wait([
      loadImage("assets/images/drive_vertical_outline.png"),
      loadImage("assets/images/drive_control_stop.png"),
      loadImage("assets/images/drive_control_up.png"),
      loadImage("assets/images/drive_control_down.png"),
    ]).then((value) => setState(() {
          driveVerticalOutline = value[0];
          driveVerticalControlStop = value[1];
          driveVerticalControlUp = value[2];
          driveVerticalControlDown = value[3];
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white.withOpacity(0.3),
        alignment: Alignment.center,
        child: VerticalJoyStick(
          size: const Size(50, 144),
          rRectRadius: 50,
          radius: 24,
          driveVerticalOutline: driveVerticalOutline,
          driveVerticalControlStop: driveVerticalControlStop,
          driveVerticalControlUp: driveVerticalControlUp,
          driveVerticalControlDown: driveVerticalControlDown,
          onMove: (y) {
            // print("y=$y");
          },
        ),
      ),
    );
  }

  Future<ui.Image> loadImage(String path) {
    // 加载资源文件
    // 把资源文件转换成Uint8List类型
    // 解析Uint8List类型的数据图片
    return rootBundle.load(path).then((value) => decodeImageFromList(value.buffer.asUint8List()));
  }
}

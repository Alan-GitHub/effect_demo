import 'dart:math';

import 'package:effect_demo/src/animation_use/joystick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'joystick_component.dart';

class JoystickData {
  JoystickData(this.offset, this.panDetail);

  Offset offset;
  Object? panDetail;
}

class JoystickUsePage extends StatefulWidget {
  const JoystickUsePage({super.key});

  @override
  State<JoystickUsePage> createState() => _JoystickUsePageState();
}

class _JoystickUsePageState extends State<JoystickUsePage> {
  bool isPaint = false;
  ui.Image? bigCircleImage;
  ui.Image? littleCircleImage;

  //默认位置
  static const Offset defaultOffset = Offset(200, 100);
  ValueNotifier<JoystickData> joystickData = ValueNotifier(JoystickData(defaultOffset, null));

  @override
  void initState() {
    super.initState();

    isPaint = false;
    loadIamge(1, "assets/images/drive_wheel_outline.png");
    loadIamge(2, "assets/images/drive_wheel_control.png");
  }

  @override
  Widget build(BuildContext context) {
    double width = 400;
    double height = 300;

    return Scaffold(
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: Container(
          color: Colors.white,
          width: width,
          height: height,
          child: isPaint
              ? JoyStick(
                  size: Size(width, height),
                  bigCircleImage: bigCircleImage,
                  littleCircleImage: littleCircleImage,
                  bgR: 80,
                  bgr: 23,
                  thresholdArc: 50 * pi / 180,
                  deadZoneArc: 10 * pi / 180,
                  onMove: (arc, x, y, r) {
                    // print("arc=$arc, x=$x, y=$y, r=$r");
                  },
                )
              : Container(),
        ),
      ),
    );
  }

  void panDown(DragDownDetails details) {
    joystickData.value = JoystickData(details.localPosition, details);
  }

  void panUpdate(DragUpdateDetails details) {
    joystickData.value = JoystickData(details.localPosition, details);
  }

  void panEnd(DragEndDetails details) {
    joystickData.value = JoystickData(defaultOffset, details);
  }

  void loadIamge(int no, String path) async {
    // 加载资源文件
    final data = await rootBundle.load(path);
    // 把资源文件转换成Uint8List类型
    final bytes = data.buffer.asUint8List();
    // 解析Uint8List类型的数据图片
    if (no == 1) {
      bigCircleImage = await decodeImageFromList(bytes);
    } else if (no == 2) {
      littleCircleImage = await decodeImageFromList(bytes);
    }

    if (bigCircleImage != null && littleCircleImage != null) {
      setState(() {
        isPaint = true;
      });
    }
  }
}

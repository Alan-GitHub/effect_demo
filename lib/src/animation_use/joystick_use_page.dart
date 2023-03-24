import 'dart:math';

import 'package:effect_demo/src/animation_use/joystick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

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
  ui.Image? bigCircleImageSport;
  ui.Image? littleCircleImageSport;

  //默认位置
  static const Offset defaultOffset = Offset(200, 100);
  ValueNotifier<JoystickData> joystickData = ValueNotifier(JoystickData(defaultOffset, null));

  @override
  void initState() {
    super.initState();

    isPaint = false;

    Future.wait([
      loadImage("assets/images/drive_wheel_outline.png"),
      loadImage("assets/images/drive_wheel_control.png"),
      loadImage("assets/images/drive_wheel_outline_sport.png"),
      loadImage("assets/images/drive_wheel_control_sport.png"),
    ]).then((value) => setState(() {
          isPaint = true;
          bigCircleImage = value[0];
          littleCircleImage = value[1];
          bigCircleImageSport = value[2];
          littleCircleImageSport = value[3];
        }));
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
                  bigCircleImageSport: bigCircleImageSport,
                  littleCircleImageSport: littleCircleImageSport,
                  bgR: 80,
                  bgr: 23,
                  thresholdArc: 45 * pi / 180,
                  deadZoneArc: 15 * pi / 180,
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

  Future<ui.Image> loadImage(String path) {
    // 加载资源文件
    // 把资源文件转换成Uint8List类型
    // 解析Uint8List类型的数据图片
    return rootBundle.load(path).then((value) => decodeImageFromList(value.buffer.asUint8List()));
  }
}

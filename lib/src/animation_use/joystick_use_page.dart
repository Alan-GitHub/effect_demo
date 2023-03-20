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
    return Scaffold(
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: GestureDetector(
          onPanDown: panDown,
          onPanUpdate: panUpdate,
          onPanEnd: panEnd,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            child: isPaint
                ? CustomPaint(
                    painter: JoystickComponent(
                        bigCircleImage: bigCircleImage,
                        littleCircleImage: littleCircleImage,
                        bigCircleR: 80,
                        littleCircleR: 28,
                        joystickData: joystickData))
                : Container(),
          ),
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

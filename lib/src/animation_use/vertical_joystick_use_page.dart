import 'package:effect_demo/src/animation_use/vertical_joystick.dart';
import 'package:flutter/material.dart';

class VerticalJoystickUsePage extends StatefulWidget {
  const VerticalJoystickUsePage({super.key});

  @override
  State<VerticalJoystickUsePage> createState() => _VerticalJoystickUsePageState();
}

class _VerticalJoystickUsePageState extends State<VerticalJoystickUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        alignment: Alignment.center,
        child: VerticalJoyStick(
          size: Size(50, 144),
          rRectRadius: 50,
          radius: 24,
          onMove: (y) {
            // print("y=$y");
          },
        ),
      ),
    );
  }
}

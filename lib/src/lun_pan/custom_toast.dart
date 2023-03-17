import 'package:flutter/material.dart';

//通过 Overlay 实现 Toast
class CustomToast {
  static OverlayEntry? _overlayEntry;

  static void show({required BuildContext context, required String message}) {
    //1、创建 overlayEntry
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: 500,
              child: Container(color: Colors.amber, child: Text(message)),
            )
          ],
        );
      },
    );

    //插入到 Overlay中显示 OverlayEntry
    Overlay.of(context)?.insert(_overlayEntry!);
  }
}
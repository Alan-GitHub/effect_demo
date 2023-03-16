import 'dart:ui';

import 'package:flutter/material.dart';

abstract class NavigationStyle {
  late Color backgroundColor;
  late Color foregroundColor;

  static NavigationStyle white = NavigationStyleWhite();
  static NavigationStyle black = NavigationStyleBlack();
}

class NavigationStyleWhite extends NavigationStyle {
  NavigationStyleWhite() : super() {
    backgroundColor = Colors.white;
    foregroundColor = Colors.black;
  }
}

class NavigationStyleBlack extends NavigationStyle {
  NavigationStyleBlack() : super() {
    backgroundColor = Colors.black;
    foregroundColor = Colors.white;
  }
}

class NavigationStyleCustom extends NavigationStyle {
  NavigationStyleCustom(Color bgColor, Color fgColor) : super() {
    backgroundColor = bgColor;
    foregroundColor = fgColor;
  }
}

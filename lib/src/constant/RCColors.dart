import 'package:flutter/material.dart';

class RCColors {
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const blue = Colors.blue;
  static const red = Colors.red;
  static const green = Colors.green;
  static const gray = Colors.grey;

  static const gray_C0C8CA = Color(0xFFC0C8CA);
  static const gray_858C8D = Color(0xFF858C8D);
  static const gray_3E474D = Color(0xFF3E474D);
  static const gray_567088 = Color(0xFF567088);
  static const gray_160F0F = Color(0xFF160F0F);
  static const gray_657881 = Color(0xFF657881);
  static const gray_364251 = Color(0xFF364251);
  static const gray_D9D9D9 = Color(0xFFD9D9D9);
  static const gray_0A1014 = Color(0xFF0A1014);
  static const gray_434D53 = Color(0xFF434D53);
  static const gray_EEEEEE = Color(0xFFEEEEEE);
  static const gray_BEBFC1 = Color(0xFFBEBFC1);
  static const gray_384247 = Color(0xFF384247);
  static const gray_5F7176 = Color(0xFF5F7176);

  static const green_A7CBD4 = Color(0xFFA7CBD4);

  static const red_E76643 = Color(0xFFE76643);

  static const yellow_FBAB36 = Color(0xFFFBAB36);

  static const blue_2ED8F7 = Color(0xFF2ED8F7);
  static const blue_179DD8 = Color(0xFF179DD8);
  static const blue_68CDE8 = Color(0xFF68CDE8);
  static const blue_6CD7F2 = Color(0xFF6CD7F2);
  static const blue_499AD5 = Color(0xFF499AD5);
  static const blue_C0F2FF = Color(0xFFC0F2FF);
  static const blue_49657E = Color(0xFF49657E);
  static const blue_2FD9F8 = Color(0xFF2FD9F8);
  static const blue_1CA9DF = Color(0xFF1CA9DF);
  static const blue_F2FDFF = Color(0xFFF2FDFF);

  static const black_3B5063 = Color(0xFF3B5063);
  static const black_0C2C3E = Color(0xFF0C2C3E);
  static const black_0F1112 = Color(0xFF0F1112);
  static const black_1F2E36 = Color(0xFF1F2E36);
  static const black_0A1C24 = Color(0xFF0A1C24);
  static const black_0B171B = Color(0xFF0B171B);
  static const black_1D292F = Color(0xFF1D292F);
  static const black_414B57 = Color(0xFF414B57);
  static const black_0F2C3C = Color(0xFF0F2C3C);
  static const black_1A2932 = Color(0xFF1A2932);
  static const black_0E191F = Color(0xFF0E191F);
  static const black_171E22 = Color(0xFF171E22);

  //根据十六进制颜色值 + 不透明度生成颜色
  static Color colorWithHexAlpha(String hexColor, double alpha) {
    int colorValue = int.parse(hexColor.replaceFirst('#', ''), radix: 16);
    int alphaValue = (alpha * 255).toInt();
    int color = alphaValue << 24 | colorValue;

    return Color(color);
  }
}

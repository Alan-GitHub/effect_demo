import 'package:effect_demo/src/animation_use/animation_use_page.dart';
import 'package:effect_demo/src/animation_use/circle_progress.dart';
import 'package:effect_demo/src/animation_use/joystick_use_page.dart';
import 'package:effect_demo/src/animation_use/vertical_joystick_use_page.dart';
import 'package:effect_demo/src/color_effect/inner_shadow_page.dart';
import 'package:effect_demo/src/expand_collapse/expand_collapse_page.dart';
import 'package:effect_demo/src/lun_pan/context_menu.dart';
import 'package:effect_demo/src/lun_pan/context_ui.dart';
import 'package:effect_demo/src/photo_lib/image_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:effect_demo/src/home_page.dart';

import '../color_effect/color_effect_page.dart';

/*
* 配置路由页面名字
* */
class RouteName {
  static const String root = '/';
  static const String colorEffectPage = 'colorEffectPage';
  static const String expandCollapsePage = 'expandCollapsePage';
  static const String kindaCodeDemo = 'kindaCodeDemo';
  static const String animationUsePage = 'animationUsePage';
  static const String joystickUsePage = 'joystickUsePage';
  static const String verticalJoystickUsePage = 'verticalJoystickUsePage';
  static const String circleProgressIndicatorDemo = 'circleProgressIndicatorDemo';
  static const String imagePickerPage = 'imagePickerPage';
  static const String innerShadowPage = 'innerShadowPage';
  static const String contextUI = 'contextUI';
}

///注册路由页面
class RouteTable {
  ///初始路由
  static const initialRoute = '/';

  ///注册路由表
  static Map<String, WidgetBuilder> registerRouteTable() {
    return {
      RouteName.root: (BuildContext context) => const HomePage(),
      RouteName.colorEffectPage: (BuildContext context) => const ColorEffectPage(),
      RouteName.expandCollapsePage: (BuildContext context) => const AnimatedContainerExample(),
      RouteName.kindaCodeDemo: (BuildContext context) => const KindaCodeDemo(),
      RouteName.animationUsePage: (BuildContext context) => const AnimationUsePage(),
      RouteName.joystickUsePage: (BuildContext context) => const JoystickUsePage(),
      RouteName.verticalJoystickUsePage: (BuildContext context) => const VerticalJoystickUsePage(),
      RouteName.circleProgressIndicatorDemo: (BuildContext context) => const CircleProgressIndicatorDemo(),
      RouteName.imagePickerPage: (BuildContext context) => const ImagePickerPage(),
      RouteName.innerShadowPage: (BuildContext context) => const InnerShadowPage(),
      RouteName.contextUI: (BuildContext context) => const ContextUI(),
    };
  }

  /*
  * 注册路由钩子
  * typedef RouteFactory = Route<dynamic> Function(RouteSettings settings);
  * */
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RouteName.loginWayPage:
      //String order = (settings.arguments as Map)['order'];
      //return MaterialPageRoute(builder: (ctx) => LoginWayPage());

      default:
        return null;
    }
  }
}

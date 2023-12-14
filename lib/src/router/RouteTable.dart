import 'package:effect_demo/src/technical_points/animation/animation_use_page_v1.dart';
import 'package:effect_demo/src/technical_points/isolate/isolate_use_page.dart';
import 'package:effect_demo/src/technical_points/streambuilder/streambuilder_use_page.dart';
import 'package:flutter/material.dart';
import 'package:effect_demo/src/home_page.dart';
import '../technical_points/animation/animation_use_page.dart';
import '../technical_points/animation/circle_progress/circle_progress.dart';
import '../technical_points/color_effect/color_effect_page.dart';
import '../technical_points/context_ui/context_ui.dart';
import '../technical_points/inner_shadow/inner_shadow_page.dart';
import '../technical_points/custom_painter/joystick/joystick_use_page.dart';
import '../technical_points/custom_painter/vertical_joystick/vertical_joystick_use_page.dart';
import '../technical_points/expand_collapse/expand_collapse_page.dart';
import '../technical_points/photo_lib/image_picker_page.dart';

/*
* 配置路由页面名字
* */
class RouteName {
  static const String root = '/';
  static const String colorEffectPage = 'colorEffectPage';
  static const String expandCollapsePage = 'expandCollapsePage';
  static const String animationUsePage = 'animationUsePage';
  static const String animationUsePageV1 = 'animationUsePageV1';
  static const String joystickUsePage = 'joystickUsePage';
  static const String verticalJoystickUsePage = 'verticalJoystickUsePage';
  static const String circleProgressIndicatorDemo = 'circleProgressIndicatorDemo';
  static const String imagePickerPage = 'imagePickerPage';
  static const String innerShadowPage = 'innerShadowPage';
  static const String contextUI = 'contextUI';
  static const String streamBuilderUsePage = 'streamBuilderUsePage';
  static const String isolateUsePage = 'isolateUsePage';
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
      RouteName.animationUsePage: (BuildContext context) => const AnimationUsePage(),
      RouteName.animationUsePageV1: (BuildContext context) => const AnimationUsePageV1(),
      RouteName.joystickUsePage: (BuildContext context) => const JoystickUsePage(),
      RouteName.verticalJoystickUsePage: (BuildContext context) => const VerticalJoystickUsePage(),
      RouteName.circleProgressIndicatorDemo: (BuildContext context) => const CircleProgressIndicatorDemo(),
      RouteName.imagePickerPage: (BuildContext context) => const ImagePickerPage(),
      RouteName.innerShadowPage: (BuildContext context) => const InnerShadowPage(),
      RouteName.contextUI: (BuildContext context) => const ContextUI(),
      RouteName.streamBuilderUsePage: (BuildContext context) => const StreamBuilderUsePage(),
      RouteName.isolateUsePage: (BuildContext context) => const IsolateUsePage(),
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

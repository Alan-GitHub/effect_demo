import 'package:effect_demo/src/expand_collapse/expand_collapse_page.dart';
import 'package:effect_demo/src/lun_pan/context_menu.dart';
import 'package:effect_demo/src/lun_pan/lunpan.dart';
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
      RouteName.expandCollapsePage: (BuildContext context) =>  const AnimatedContainerExample(),
      RouteName.kindaCodeDemo: (BuildContext context) =>  const KindaCodeDemo(),
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

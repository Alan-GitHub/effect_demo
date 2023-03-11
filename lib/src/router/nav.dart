import 'package:flutter/material.dart';

class Nav {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  ///页面返回
  static pop() {
    //Navigator.of(context).pop();
    navigatorKey.currentState?.pop();
  }

  ///推出新的页面
  static pushName(String pageName, {Object? params}) {
    navigatorKey.currentState?.pushNamed(pageName, arguments: params);
  }
}

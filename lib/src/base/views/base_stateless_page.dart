import 'package:flutter/material.dart';
import '../../theme/navigation_style.dart';
import '../../router/nav.dart';

class BaseStatelessPageWidget extends StatelessWidget {
  // 导航栏标题
  String get navTitle => "";
  // 是否隐藏导航栏
  bool get isNavigationBarHidden => true;
  // 导航栏风格
  NavigationStyle get navigationStyle => NavigationStyle.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: configAppBar(),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[baseBuild(context)],
      ),
    );
  }

  // 配置导航栏
  PreferredSizeWidget? configAppBar() {
    if (isNavigationBarHidden) {
      return null;
    } else {
      return AppBar(
        // 标题文案
        title: buildTitleWidget,
        backgroundColor: navigationStyle.backgroundColor,
        elevation: 0,
        leading: buildLeadingWidget,
        centerTitle: true,
      );
    }
  }

  Widget get buildTitleWidget {
    if (navTitle.length == 0) {
      return Container();
    }

    return Container(
      child: Text(
        '$navTitle',
        style: TextStyle(color: navigationStyle.foregroundColor, fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget get buildLeadingWidget {
    return const BackButton();
  }

  // -------- 子类覆盖系列方法 --------- //
  // 加载方法
  void onLoad() {}

  // build 方法
  Widget baseBuild(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

  // 卸载方法
  void unLoad() {}
}

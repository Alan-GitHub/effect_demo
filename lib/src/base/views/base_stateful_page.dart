import 'package:flutter/material.dart';

import '../../theme/navigation_style.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({super.key});

  @override
  BaseStatefulPageState createState() => getState();

  BaseStatefulPageState getState();
}

abstract class BaseStatefulPageState<T extends BaseStatefulPage> extends State<T> {
  // 导航栏标题
  String navTitle = "";
  // 是否隐藏导航栏
  bool isNavigationBarHidden = false;
  // 导航栏风格
  NavigationStyle navigationStyle = NavigationStyle.black;

  /// 导航栏右侧按钮列表
  List<Widget>? navRightBtnWidgets = [];

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: configAppBar(),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[baseBuild(context)],
          );
        },
      ),
      drawer: getDrawer(),
      endDrawer: getEndDrawer(),
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
        actions: navRightBtnWidgets,
        centerTitle: true,
      );
    }
  }

  Widget get buildTitleWidget {
    if (navTitle.isEmpty) {
      return Container();
    }

    return Text(
      navTitle,
      style: TextStyle(color: navigationStyle.foregroundColor, fontSize: 17, fontWeight: FontWeight.w500),
    );
  }

  Widget get buildLeadingWidget {
    return const BackButton();
  }

  // -------- life cycle --------- //
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    unLoad();
    super.dispose();
  }
  // -------- life cycle end --------- //

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

  /// drawer 左侧抽屉内容
  Widget? getDrawer() => null;

  /// endDrawer 右侧抽屉内容
  Widget? getEndDrawer() => null;
}

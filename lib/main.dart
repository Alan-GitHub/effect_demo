import 'package:effect_demo/src/router/RouteTable.dart';
import 'package:effect_demo/src/router/nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RouteTable.registerRouteTable(),
      initialRoute: RouteTable.initialRoute,
      onGenerateRoute: RouteTable.generateRoute,
      navigatorKey: Nav.navigatorKey,
    );
  }
}

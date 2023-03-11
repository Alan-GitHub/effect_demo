import 'package:effect_demo/src/router/RouteTable.dart';
import 'package:effect_demo/src/router/nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("特效Demo"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Nav.pushName(RouteName.colorEffectPage);
                  },
                  child: const Text("颜色渐变特效"),
                )
              ],
            ),
          ),
        ));
  }
}

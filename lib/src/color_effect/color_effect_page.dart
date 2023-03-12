import 'package:effect_demo/src/color_effect/color_mix_effect_linear.dart';
import 'package:effect_demo/src/color_effect/color_mix_effect_radial.dart';
import 'package:effect_demo/src/color_effect/color_mix_effect_sweep.dart';
import 'package:effect_demo/src/color_effect/color_mix_effect_text.dart';
import 'package:flutter/material.dart';

class ColorEffectPage extends StatefulWidget {
  const ColorEffectPage({super.key});

  @override
  State<ColorEffectPage> createState() => _ColorEffectPageState();
}

class _ColorEffectPageState extends State<ColorEffectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("颜色特效"),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset("assets/images/2.jpeg", fit: BoxFit.cover)),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: ColorMixEffectLinear(),
                          );
                        });
                  },
                  child: const Text("颜色与图片融合-渐变"),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: ColorMixEffectRadial(),
                          );
                        });
                  },
                  child: const Text("颜色与图片融合-放射"),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: ColorMixEffectSweep(),
                          );
                        });
                  },
                  child: const Text("颜色与图片融合-扇形"),
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                            child: ColorMixEffectText(),
                          );
                        });
                  },
                  child: const Text("颜色与文字融合"),
                ),

                // GlowingBorder(
                //   width: 12.0,
                //   glowColor: Colors.blue,
                //   child: Container(
                //     width: 200.0,
                //     height: 100.0,
                //     color: Colors.white,
                //   ),
                // ),

                // LightBox(),

                // const MovingLight(),
              ],
            )
          ],
        ));
  }
}

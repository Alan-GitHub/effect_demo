import 'package:flutter/material.dart';
import 'inner_shadow.dart';

class InnerShadowPage extends StatelessWidget {
  const InnerShadowPage({Key? key}) : super(key: key);

  Color _shadowColor() => const Color.fromRGBO(222, 234, 252, 1);

  Widget _textWidget() => const Text('data', style: TextStyle(fontSize: 36, color: Colors.black));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('InnerShadow'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _shadowColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 10,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                  child: _textWidget(),
                ),
              ),
            ),
            InnerShadow(
              blur: 6,
              shadowColor: _shadowColor(),
              offset: const Offset(2, 2),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("abc"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() => _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> with TickerProviderStateMixin {
  double _size = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('向上展开收起效果'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            width: 50,
            height: _size,
            color: Colors.green,
            duration: const Duration(milliseconds: 80),
            child: const SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.video_call)),
                  IconButton(onPressed: null, icon: Icon(Icons.phone)),
                  IconButton(onPressed: null, icon: Icon(Icons.mic)),
                  IconButton(onPressed: null, icon: Icon(Icons.close)),
                  IconButton(onPressed: null, icon: Icon(Icons.backpack)),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("点我"),
        onPressed: () {
          setState(() {
            _size = _size == 40 ? 250 : 40;
          });
        },
      ),
    );
  }
}

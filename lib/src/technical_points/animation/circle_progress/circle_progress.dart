import 'package:flutter/material.dart';

class CircleProgressIndicatorDemo extends StatefulWidget {
  const CircleProgressIndicatorDemo({super.key});

  @override
  State<CircleProgressIndicatorDemo> createState() => _CircleProgressIndicatorDemoState();
}

class _CircleProgressIndicatorDemoState extends State<CircleProgressIndicatorDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _animationColor;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //   duration: const Duration(seconds: 3),
    //   vsync: this,
    //   animationBehavior: AnimationBehavior.preserve,
    // )..forward();
    //
    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.linear,
    //   reverseCurve: Curves.fastOutSlowIn,
    // )..addStatusListener((status) {
    //     if (status == AnimationStatus.dismissed) {
    //       _controller.forward();
    //     } else if (status == AnimationStatus.completed) {
    //       _controller.reverse();
    //     }
    //   });

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..reverse(from: 1.0);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );

    _animationColor = ColorTween(begin: Colors.red, end: Colors.deepPurpleAccent).animate(_animation);
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _buildIndicators(BuildContext context, Widget? child) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 32),
        CircularProgressIndicator(
          value: _animation.value,
          color: Colors.green,
          backgroundColor: Colors.orange,
          valueColor: _animationColor,
          strokeWidth: 2,
          semanticsLabel: "abc",
          semanticsValue: "123",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("圆形进度条"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: AnimatedBuilder(
              animation: _animation,
              builder: _buildIndicators,
            ),
          ),
        ),
      ),
    );
  }
}

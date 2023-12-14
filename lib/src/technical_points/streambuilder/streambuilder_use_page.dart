import 'dart:async';
import 'package:flutter/material.dart';

class StreamBuilderUsePage extends StatefulWidget {
  const StreamBuilderUsePage({super.key});

  @override
  State<StatefulWidget> createState() => _StreamBuilderUsePageState();
}

class _StreamBuilderUsePageState extends State<StreamBuilderUsePage> {
  final StreamController<int> _streamController = StreamController<int>(); // 创建一个StreamController对象
  late final Timer _timer;
  static int count = 0;

  // late final Stream<int> _stream;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(count++); // 向Stream添加数据
    });

    // _stream = Stream.periodic(const Duration(seconds: 1), (i) {
    //   return i;
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close(); // 关闭Stream

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: _streamController.stream, // 使用StreamController对象作为stream参数
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Text('当前时间 ${snapshot.data}'); // 使用snapshot.data获取最新的数据
          } else if (snapshot.hasError) {
            return Text('出错了：${snapshot.error}'); // 使用snapshot.error获取错误信息
          } else {
            return const CircularProgressIndicator(); // 使用CircularProgressIndicator显示等待状态
          }
        },
      ),
    );

    // return Center(
    //   child: StreamBuilder<int>(
    //     stream: _stream, //
    //     //initialData: ,// a Stream<int> or null
    //     builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
    //       print("object");
    //
    //       if (snapshot.hasError) {
    //         return Text('Error: ${snapshot.error}');
    //       }
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.none:
    //           return const Text('没有Stream');
    //         case ConnectionState.waiting:
    //           return const Text('等待数据...');
    //         case ConnectionState.active:
    //           return Text('active: ${snapshot.data}');
    //         case ConnectionState.done:
    //           return const Text('Stream 已关闭');
    //       }
    //     },
    //   ),
    // );
  }
}

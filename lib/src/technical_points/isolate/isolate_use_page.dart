import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateUsePage extends StatefulWidget {
  const IsolateUsePage({super.key});

  @override
  State<StatefulWidget> createState() => _IsolateUsePageState();
}

class _IsolateUsePageState extends State<IsolateUsePage> {
  /// 在父Isolate中调用
  late final SendPort spHandler;
  static int count = 0;

  @override
  void initState() {
    super.initState();

    initIsolate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          spHandler.send("发送消息：${count++}");
        },
        child: const Text("点我"),
      ),
    );
  }

  void initIsolate() async {
    count = 0;
    ReceivePort receivePort = ReceivePort();

    /// 创建子Isolate对象
    Isolate isolate = await Isolate.spawn(workIsolate, receivePort.sendPort);

    /// 监听子Isolate的返回数据
    receivePort.listen((data) {
      print(data);

      if (data is SendPort) {
        spHandler = data;
      }

      int? keyValue = int.tryParse(data.toString().substring(5));

      /// 关闭Isolate对象
      if (keyValue == 10) {
        /// 通知子isolate关闭
        spHandler.send("close");

       receivePort.close();
       isolate.kill(priority: Isolate.immediate);
      }
    });
  }
}

/// 子Isolate对象的入口函数，可以在该函数中做耗时操作,
/// 必须是顶级函数，或者类中静态函数
void workIsolate(SendPort sendPort) {
  sendPort.send("hello");

  ReceivePort workrp = ReceivePort();
  sendPort.send(workrp.sendPort);

  workrp.listen((message) {
    print(message);

    if (message == "close") {
      workrp.close();
    }

    int? keyValue = int.tryParse(message.toString().substring(5));

    sendPort.send("收到消息：$keyValue");
  });
}

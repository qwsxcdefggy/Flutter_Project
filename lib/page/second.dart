import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

//main function can't async
class _SecondState extends State<Second> {
  // 异步加载文本文件的方法
  Future<String> loadAssetText() async {
    try {
      String data = await rootBundle.loadString('assets/sample.txt');

      return data;
    } catch (e) {
      // print("加载失败: $e"); // 调试输出
      return "加载失败: $e";
    }
  }

  Widget text_(IconData icon, String text, VoidCallback onPressed) {
    return SelectableText(
      text,
      style: TextStyle(fontSize: 16),
      cursorColor: Colors.orange,
      onTap: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('读取文本文件'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          // 添加返回按钮
          icon: const Icon(Icons.add_call),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.business), onPressed: () {}),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      body: FutureBuilder(
        future: loadAssetText(), // 调用加载方法
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('错误抛出: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: text_(Icons.add_call, snapshot.data.toString(), () {
                  print("can select text");
                }),
                //Text(
                //   snapshot.data ?? '文件内容为空', // 显示加载的文本或备用提示
                //   style: const TextStyle(fontSize: 16),
                // ),
              ),
            );
          }
        },
      ),
    );
  }
}

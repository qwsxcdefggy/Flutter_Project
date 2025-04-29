import 'package:flutter/material.dart';

class GridLayoutScreen extends StatelessWidget {
  const GridLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网格布局示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3, // 每行显示的网格数量
          crossAxisSpacing: 10, // 水平间距
          mainAxisSpacing: 5, // 垂直间距
          children: List.generate(30, (index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue[100 * (index % 9 + 1)],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '项目 $index',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:math'; // 用于生成随机数

class SidebarLayout extends StatelessWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sidebar Layout'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Sidebar Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.image), // 使用一个图片图标来表示这个选项
              title: Text('Show Random Image'),
              onTap: () {
                Navigator.pop(context); // 先关闭抽屉
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomImagePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Main Content Area\n点击左上角的菜单按钮来打开抽屉',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class RandomImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成一个随机数来创建不同的图片 URL
    final random = Random();
    final randomNumber = random.nextInt(1000); // 假设我们只需要一个范围内的随机数
    final imageUrl = 'https://picsum.photos/600/300?random=$randomNumber';

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Image'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
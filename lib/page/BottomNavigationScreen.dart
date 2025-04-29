import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _currentIndex = 0; // 当前选中的导航项索引

  // 页面内容列表
  final List<Widget> _pages = [
    const Center(child: Text('首页内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('搜索内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('收藏内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('个人中心', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部导航示例'),
        centerTitle: true,
      ),

      body: _pages[_currentIndex], // 显示当前页面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 当前选中项
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 点击时更新状态
          });
        },
        type: BottomNavigationBarType.fixed, // 固定样式（超过4个item时需要）
        selectedItemColor: Colors.blue, // 选中项颜色
        unselectedItemColor: Colors.grey, // 未选中项颜色
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '搜索',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '收藏',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Combine extends StatefulWidget {
  const Combine({super.key});

  @override
  CombineState createState() => CombineState();
}

class CombineState extends State<Combine> {
  // 定义页面内容
  final List<Widget> _pages = [
    const Center(child: Text('首页内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('搜索内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('收藏内容', style: TextStyle(fontSize: 24))),
    const Center(child: Text('个人中心', style: TextStyle(fontSize: 24))),
    const Center(child: Text('设置内容', style: TextStyle(fontSize: 24))),
  ];

  // 定义列表项
  final List<Map<String, dynamic>> items = [
    {'icon': Icons.map, 'title': '地图', 'onTap': () {}},
    {
      'icon': Icons.photo_album,
      'title': '相册',
      'onTap': () {
        // 处理相册点击事件
      },
    },
    {
      'icon': Icons.settings,
      'title': '设置',
      'onTap': () {
        // 处理设置点击事件
      },
    },
  ];

  int _currentIndex = 0;

  // 安全处理点击事件的方法
  void _safeHandleTap(Function onTap, BuildContext context) {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onTap();
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combine', style: TextStyle(color: Colors.white)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                '菜单',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // 使用安全方式处理点击事件
            ...items.map(
                  (item) => ListTile(
                leading: Icon(item['icon']),
                title: Text(item['title']),
                onTap: () => _safeHandleTap(item['onTap'], context),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('关于'),
              onTap: () => _safeHandleTap(() {}, context),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          if (mounted) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.search), label: '搜索'),
          NavigationDestination(icon: Icon(Icons.favorite), label: '收藏'),
          NavigationDestination(icon: Icon(Icons.person), label: '我的'),
          NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
        ],
      ),
    );
  }
}
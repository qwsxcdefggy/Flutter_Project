import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project2/page/route1.dart';

class ContainLayout extends StatefulWidget {
  const ContainLayout({super.key});

  @override
  State<ContainLayout> createState() => _ContainLayoutState();
}

class _ContainLayoutState extends State<ContainLayout> {
  String _currentTime = '';
  Timer? _timer;
  Timer? _timer2;
  var Test = 0;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer2 = Timer.periodic(const Duration(seconds: 2), (t) => updatetest());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _updateTime(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  void updatetest() => setState(() => Test++);

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    setState(() => _currentTime = formattedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.withOpacity(0.05),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 时间显示区域
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlue.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 40,
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _currentTime,
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '计数: $Test',
                        style: const TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 按钮区域
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildCustomButton(
                      Icons.touch_app,
                      '点击我',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Route1('from contain1!'),
                        ),
                      ).then((value) => print('返回数据: $value')),
                    ),
                    _buildCustomButton(
                      Icons.grid_on,
                      'to grid',
                      () => Navigator.pushNamed(context, '/grid'),
                    ),
                    _buildCustomButton(
                      Icons.credit_card,
                      'to card',
                      () => Navigator.pushNamed(context, '/card'),
                    ),
                    _buildCustomButton(
                      Icons.waterfall_chart,
                      'to waterfall',
                      () => Navigator.pushNamed(context, '/waterfall'),
                    ),
                    _buildCustomButton(
                      Icons.keyboard_arrow_up,
                      'to bottomscreen',
                      () => Navigator.pushNamed(context, '/bottomscreen'),
                    ),
                    _buildCustomButton(
                      Icons.menu,
                      'to sider',
                      () => Navigator.pushNamed(context, '/sider'),
                    ),
                    _buildCustomButton(
                      Icons.widgets,
                      'to combine',
                      () => Navigator.pushNamed(context, '/combine'),
                    ),
                    _buildCustomButton(
                      Icons.widgets,
                      'to Second',
                      () => Navigator.pushNamed(context, '/second'),
                    ),
                    _buildCustomButton(
                      Icons.widgets,
                      'to Chart_',
                      () => Navigator.pushNamed(context, '/chart_'),
                    ),
                    _buildCustomButton(
                      Icons.widgets,
                      'to  web',
                      () => Navigator.pushNamed(context, '/web1'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 自定义带图标的按钮
  Widget _buildCustomButton(
    IconData icon,
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(text, style: TextStyle(fontFamily: 'SimKai')),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
      ),
    );
  }
}

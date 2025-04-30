import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart4_ extends StatefulWidget {
  const Chart4_({super.key});

  @override
  _Chart4_State createState() => _Chart4_State();
}

class _Chart4_State extends State<Chart4_> {
  List<double> _values = []; // 存储饼图各部分的值
  final int _numberOfSections = 5; // 饼图的分区数量
  late Timer _timer; // 定时器
  Duration _updateInterval = const Duration(milliseconds: 500); // 默认更新间隔为0.5秒
  final List<Color> _sectionColors = [ // 分区颜色
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    _initData();
    _startTimer();
  }

  // 初始化数据
  void _initData() {
    _values = List.generate(_numberOfSections, (index) => 1.0); // 初始值设为1
  }

  // 开始定时器
  void _startTimer() {
    _timer = Timer.periodic(_updateInterval, (timer) => _updateData());
  }

  // 停止定时器
  void _stopTimer() {
    _timer.cancel();
  }

  // 模拟实时数据更新
  void _updateData() {
    final random = Random();
    setState(() {
      _values = List.generate(_numberOfSections, (index) => random.nextDouble() * 10 + 1); // 值在1-11之间
    });
  }

  // 改变更新速度
  void changeUpdateSpeed(Duration newInterval) {
    _stopTimer();
    setState(() {
      _updateInterval = newInterval;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  // 构建饼图
  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: _values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return PieChartSectionData(
            value: value,
            color: _sectionColors[index % _sectionColors.length],
            radius: 25, // 半径
            title: '${value.toStringAsFixed(1)}', // 显示数值
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            badgeWidget: Text(
              '区${index + 1}',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            badgePositionPercentageOffset: 0.98, // 标签位置
          );
        }).toList(),
        centerSpaceRadius: 40, // 中心空白区域大小
        sectionsSpace: 2, // 分区之间的间距
        startDegreeOffset: -90, // 起始角度偏移(12点钟方向开始)
      ),
      swapAnimationDuration: const Duration(milliseconds: 300), // 动画时长
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('实时饼图'),
        actions: [
          PopupMenuButton<Duration>(
            icon: const Icon(Icons.speed),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Duration(seconds: 1),
                child: Text('1秒'),
              ),
              const PopupMenuItem(
                value: Duration(seconds: 2),
                child: Text('2秒'),
              ),
              const PopupMenuItem(
                value: Duration(milliseconds: 500),
                child: Text('0.5秒'),
              ),
            ],
            onSelected: (value) {
              changeUpdateSpeed(value);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: _buildPieChart(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 显示图例
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _values.asMap().entries.map((entry) {
                final index = entry.key;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: _sectionColors[index % _sectionColors.length],
                    ),
                    const SizedBox(width: 5),
                    Text('区${index + 1}: ${entry.value.toStringAsFixed(1)}'),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
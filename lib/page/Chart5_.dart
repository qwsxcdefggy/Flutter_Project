import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart5_ extends StatefulWidget {
  const Chart5_({super.key});

  @override
  _Chart5_State createState() => _Chart5_State();
}

class _Chart5_State extends State<Chart5_> {
  List<double> _values = []; // 存储柱状图各部分的值
  final int _numberOfSections = 5; // 柱状图的分区数量
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
    _values = List.generate(_numberOfSections, (index) => Random().nextDouble() * 10 + 1); // 初始值在1-11之间
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

  // 构建柱状图
  BarChart _buildBarChart() {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(enabled: false), // 禁用触摸交互
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < _numberOfSections) {
                  return Text('区${index + 1}');
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: false), // 隐藏网格线
        borderData: FlBorderData(show: false), // 隐藏边框
        barGroups: _values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: _sectionColors[index % _sectionColors.length],
                width: 20, // 柱状图宽度
                borderRadius: BorderRadius.circular(4), // 圆角
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('实时柱状图'),
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
                  child: _buildBarChart(),
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
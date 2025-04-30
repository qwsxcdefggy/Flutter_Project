import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart3_ extends StatefulWidget {
  const Chart3_({super.key});

  @override
  _Chart3_State createState() => _Chart3_State();
}

class _Chart3_State extends State<Chart3_> {
  List<double> _values = []; // 存储雷达图各轴的值
  final int _numberOfSides = 6; // 雷达图的边数(轴数)
  late Timer _timer; // 定时器
  Duration _updateInterval = const Duration(milliseconds: 500); // 默认更新间隔为0.5秒

  @override
  void initState() {
    super.initState();
    _initData();
    _startTimer();
  }

  // 初始化数据
  void _initData() {
    _values = List.generate(_numberOfSides, (index) => 0);
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
      _values = List.generate(_numberOfSides, (index) => random.nextDouble() * 10);
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

  // 构建雷达图
  Widget _buildRadarChart() {
    return RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            dataEntries: _values.map((value) => RadarEntry(value: value)).toList(),
            fillColor: Colors.blue.withOpacity(0.3),
            borderColor: Colors.blue,
            borderWidth: 2,
          ),
        ],
        radarBackgroundColor: Colors.transparent,
        radarBorderData: const BorderSide(color: Colors.grey, width: 1),
        tickCount: 5,
        ticksTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
        tickBorderData: const BorderSide(color: Colors.grey, width: 0.5),
        gridBorderData: const BorderSide(color: Colors.grey, width: 1),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
        getTitle: (index, angle) {
          return RadarChartTitle(
            text: '维度 ${index + 1}',
            angle: angle,
          );
        },
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('实时雷达图'),
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
        child: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: _buildRadarChart(),
          ),
        ),
      ),
    );
  }
}
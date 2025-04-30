import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart2_ extends StatefulWidget {
  const Chart2_({super.key});

  @override
  _Chart2_State createState() => _Chart2_State();
}

class _Chart2_State extends State<Chart2_> {
  List<FlSpot> _dataPoints = []; // 存储折线图数据点
  final int _maxPoints = 10;      // 最大显示的数据点数量
  double _xValue = 0;             // 当前X轴位置
  late Timer _timer;              // 定时器
  Duration _updateInterval = const Duration(milliseconds: 400); // 修改为0.5秒更新

  @override
  void initState() {
    super.initState();
    _initData();
    _startTimer();
  }

  // 初始化数据
  void _initData() {
    _dataPoints = List.generate(_maxPoints, (index) => FlSpot(index.toDouble(), 0));
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
      _xValue += 1;
      double newY = random.nextDouble() * 10; // 生成0-10的随机数
      _dataPoints.add(FlSpot(_xValue, newY));
      // 限制数据点数量，移除旧数据
      if (_dataPoints.length > _maxPoints) {
        _dataPoints.removeAt(0);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('实时折线图'),
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
        child: LineChart(
          LineChartData(
            minX: _xValue - _maxPoints + 1, // 动态调整X轴范围
            maxX: _xValue,
            minY: 0,
            maxY: 10,
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints,
                isCurved: true,
                color: Colors.blue,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
              ),
            ],
            borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
                left: BorderSide(color: Colors.grey, width: 1),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    // 只显示整数位置的X轴标签
                    if (value.toInt() == value) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    );
                  },
                  interval: 1,
                ),
              ),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
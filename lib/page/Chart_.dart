import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart_ extends StatefulWidget {
  const Chart_({super.key});

  @override
  State<Chart_> createState() => _ChartState();
}

class _ChartState extends State<Chart_> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final chartSize = screenSize / 8; // 自适应屏幕的1/4

    return SizedBox(
      height: chartSize.height,
      width: chartSize.width,
      child: LineChart(LineChartData(
        lineBarsData: [LineChartBarData(
            spots: const [
              FlSpot(0.0, 1.0), // 全部显式写成double
              FlSpot(1.0, 3.0),
              FlSpot(2.0, 2.0),
              FlSpot(3.0, 5.0),
              FlSpot(4.0, 4.0),
            ],
          isCurved: true,
          color: Colors.blue,
        )],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (v,_) => Text(['Jan','Feb','Mar','Apr','May'][v.toInt()]),
          )),
        ),
      )), // 再嫌慢就把你CPU超频到冒烟！💨
    );
  }
}

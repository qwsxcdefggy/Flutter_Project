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
    return SizedBox(
      height: 200, // 高度
      width: 300,  // 宽度
      child: BarChart(
        BarChartData(
          // 设置Y轴范围为0-50
          minY: 0,
          maxY: 50,
          // 定义每个柱子的数据
          barGroups: [
            BarChartGroupData(
              x: 0, // X轴索引
              barRods: [
                BarChartRodData(
                  toY: 2.7, // 柱子高度（数值范围0-50）
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  toY: 2.5,
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 2.0,
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 1.4,
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: 1.3,
                  color: Colors.blue,
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  toY: 1.0,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
          // 自定义X轴标签（可选）
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // 自定义X轴标签文本
                  final labels = ['A', 'B', 'C', 'D', 'E', 'F'];
                  return Text(labels[value.toInt()]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
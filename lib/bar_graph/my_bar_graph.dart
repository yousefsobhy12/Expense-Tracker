import 'package:expense_tracker/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({
    super.key,
    this.maxY,
    required this.satAmount,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
  });
  final double? maxY;
  final double satAmount;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      satAmount: satAmount,
      sunAmount: sunAmount,
      monAmount: monAmount,
      tueAmount: tueAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
    );
    myBarData.initializeDataBar();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        barGroups: myBarData.dataBar
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [BarChartRodData(toY: data.y)],
              ),
            )
            .toList(),
      ),
    );
  }
}

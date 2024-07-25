// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatelessWidget {
  final List<FlSpot> data;

  const WeightChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      // padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        // border: Border.all(color: App.color.tertiaryContainer.withAlpha(100))
      ),
      child: LineChart(
        LineChartData(
          // backgroundColor: Colors.white,
          minX: 0,
          minY: 0,
          lineTouchData: const LineTouchData(enabled: false),
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              color: Colors.teal[800],
              // isStrokeJoinRound: true,
              spots: data,
              belowBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
                color: Colors.teal[800]!.withAlpha(75),
              ),
            ),
          ],
          borderData: FlBorderData(
            border: const Border(),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPressureChart extends StatelessWidget {
  final List<FlSpot> highest;
  final List<FlSpot> lowest;

  const BloodPressureChart({
    super.key,
    required this.highest,
    required this.lowest,
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
              color: Colors.red[700],
              // isStrokeJoinRound: true,
              spots: highest,
              belowBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
                color: Colors.red[700]!.withAlpha(75),
              ),
            ),
            LineChartBarData(
              isCurved: true,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              color: Colors.blue[800],
              // isStrokeJoinRound: true,
              spots: lowest,
              belowBarData: BarAreaData(
                show: true,
                applyCutOffY: true,
                color: Colors.blue[800]!.withAlpha(75),
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

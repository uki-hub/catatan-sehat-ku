import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepsRecord extends StatelessWidget {
  const StepsRecord({super.key});

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'M';
        break;
      case 1:
        text = 'T';
        break;
      case 2:
        text = 'W';
        break;
      case 3:
        text = 'T';
        break;

      case 4:
        text = 'F';
        break;

      case 5:
        text = 'S';
        break;

      case 6:
        text = 'S';
        break;

      default:
        return Container();
    }

    return Text(
      text,
      style: App.text.labelMedium!.copyWith(
        color: App.color.tertiary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
      decoration: BoxDecoration(
        color: App.color.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Steps in Week",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.tertiary),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "",
            style: App.text.labelMedium!.copyWith(color: App.color.tertiaryContainer),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 80.h,
            child: LineChart(
              LineChartData(
                minX: 0,
                minY: 0,
                lineTouchData: const LineTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                      showTitles: true,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    color: App.color.tertiary,
                    // isStrokeJoinRound: true,
                    spots: const [
                      FlSpot(0, 0),
                      FlSpot(1, 0),
                      FlSpot(2, 0),
                      FlSpot(3, 0),
                      FlSpot(4, 0),
                      FlSpot(5, 0),
                      FlSpot(6, 0),
                    ],
                    belowBarData: BarAreaData(
                      show: true,
                      applyCutOffY: true,
                      color: App.color.tertiary.withAlpha(100),
                    ),
                  )
                ],
                borderData: FlBorderData(
                  border: Border(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

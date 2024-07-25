import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HealthRecord extends StatelessWidget {
  const HealthRecord({super.key});

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
    final weightCubit = context.watch<WeightRecorderCubit>();
    final bloodCubit = context.watch<BloodPressureRecorderCubit>();
    final sleepCubit = context.watch<SleepRecorderCubit>();
    final cholesterolCubit = context.watch<CholesterolRecorderCubit>();

    final result = <FlSpot>[];

    for (var i = 0; i < 7; i++) {
      final weightData = weightCubit.getPastReportSingle(DateTime.now().subtract(Duration(days: i)));
      final bloodData = bloodCubit.getPastReportSingle(DateTime.now().subtract(Duration(days: i)));
      final sleepData = sleepCubit.getPastReportSingle(DateTime.now().subtract(Duration(days: i)));
      final cholesterolData = cholesterolCubit.getPastReportSingle(DateTime.now().subtract(Duration(days: i)));

      final weightScore = weightData != null ? weightCubit.getScore(records: [weightData]) : 0;
      final bloodScore = bloodData != null ? bloodCubit.getScore(records: [bloodData]) : 0;
      final sleepScore = sleepData != null ? sleepCubit.getScore(records: [sleepData]) : 0;
      final cholesterolScore = cholesterolData != null ? cholesterolCubit.getScore(records: [cholesterolData]) : 0;

      final overallRating = (weightScore + bloodScore + sleepScore + cholesterolScore) / 4.0;

      result.add(FlSpot(i.toDouble(), overallRating));
    }

    final noData = result.every((d) => d.y == 0);

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
              "Your Health\nin Week",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.primary),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 80.h,
            child: noData
                ? Center(
                  child: Text(
                      'No Data Recorded\nin the past week',
                      textAlign: TextAlign.center,
                      style: App.text.bodyMedium!.copyWith(color: App.color.primaryContainer.withAlpha(200)),
                    ),
                )
                : LineChart(
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
                          color: App.color.primaryContainer,
                          // isStrokeJoinRound: true,
                          spots: result,
                          belowBarData: BarAreaData(
                            show: true,
                            applyCutOffY: true,
                            color: App.color.primaryContainer.withAlpha(100),
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

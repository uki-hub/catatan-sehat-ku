import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/models/sleep_record_model.dart';
import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SleepReport extends StatelessWidget {
  const SleepReport({super.key});

  Duration calculateSleepDuration(SleepRecordModel record) {
    return record.to.difference(record.from);
  }

  String formatDuration(Duration duration) {
    final twoDigitHours = duration.inHours.toString();
    final twoDigitMinutes = duration.inMinutes.remainder(60).toString();
    return "$twoDigitHours Hours $twoDigitMinutes Minutes";
  }

  Map<String, dynamic> analyzeSleepRecords(List<SleepRecordModel> records) {
    if (records.isEmpty) {
      return {
        'highest': {'duration': Duration.zero, 'from': null, 'to': null, 'recordDate': null},
        'lowest': {'duration': Duration.zero, 'from': null, 'to': null, 'recordDate': null},
        'average': Duration.zero,
      };
    }

    final sleepDurations = records.map(calculateSleepDuration).toList();
    final totalSleepDuration = sleepDurations.fold(Duration.zero, (sum, duration) => sum + duration);

    SleepRecordModel highestSleepRecord = records.first;
    SleepRecordModel lowestSleepRecord = records.first;

    for (var record in records) {
      Duration duration = calculateSleepDuration(record);
      if (duration > calculateSleepDuration(highestSleepRecord)) {
        highestSleepRecord = record;
      }
      if (duration < calculateSleepDuration(lowestSleepRecord)) {
        lowestSleepRecord = record;
      }
    }

    final highestSleepDuration = calculateSleepDuration(highestSleepRecord);
    final lowestSleepDuration = calculateSleepDuration(lowestSleepRecord);
    final averageSleepDuration = totalSleepDuration ~/ records.length;

    return {
      'highest': {
        'duration': formatDuration(highestSleepDuration),
        'from': highestSleepRecord.from,
        'to': highestSleepRecord.to,
        'recordDate': highestSleepRecord.recordDate,
      },
      'lowest': {
        'duration': formatDuration(lowestSleepDuration),
        'from': lowestSleepRecord.from,
        'to': lowestSleepRecord.to,
        'recordDate': lowestSleepRecord.recordDate,
      },
      'average': formatDuration(averageSleepDuration),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SleepRecorderCubit, SleepRecorderState>(
      builder: (context, state) {
        final cubit = context.read<SleepRecorderCubit>();

        final data = cubit.generateChartData(state.records);
        final noData = data.isEmpty;

        final records = [...state.records];

        final analyzed = analyzeSleepRecords(state.records);

        final highest = analyzed['highest']['duration'];
        final highestFrom = noData ? "-" : DateFormat('hh:mm a').format(analyzed['highest']['from']);
        final highestTo = noData ? "-" : DateFormat('hh:mm a').format(analyzed['highest']['to']);
        final highestDate = noData ? "-" : DateFormat('dd MMM yyyy hh:mm a').format(analyzed['highest']['recordDate']);

        final lowest = analyzed['lowest']['duration'];
        final lowestFrom = noData ? "-" : DateFormat('hh:mm a').format(analyzed['lowest']['from']);
        final lowestTo = noData ? "-" : DateFormat('hh:mm a').format(analyzed['lowest']['to']);
        final lowestDate = noData ? "-" : DateFormat('dd MMM yyyy hh:mm a').format(analyzed['lowest']['recordDate']);

        final average = analyzed['average'];

        return Card(
          color: App.color.surfaceContainerHigh,
          clipBehavior: Clip.antiAlias,
          child: ExpandablePanel(
            controller: ExpandableController(initialExpanded: false),
            theme: ExpandableThemeData(
              useInkWell: false,
              iconColor: App.color.onSurface,
              iconSize: 28.sp,
              expandIcon: Icons.arrow_drop_down_rounded,
              collapseIcon: Icons.arrow_drop_up_rounded,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
            ),
            header: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
              decoration: BoxDecoration(color: App.color.surfaceContainerHigh),
              child: Text(
                "Sleep",
                style: App.text.titleLarge!.copyWith(color: App.color.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
            collapsed: const SizedBox(),
            expanded: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
              decoration: BoxDecoration(color: App.color.surfaceContainerHigh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(color: App.color.surfaceContainerLowest, borderRadius: BorderRadius.circular(7), border: Border.all(color: App.color.tertiaryContainer.withAlpha(100))),
                    child: noData
                        ? Center(
                            child: Text(
                              "No Recorded Data",
                              style: App.text.titleMedium!.copyWith(color: Colors.grey[300], fontWeight: FontWeight.w600),
                            ),
                          )
                        : LineChart(
                            LineChartData(
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
                                  color: App.color.tertiary,
                                  // isStrokeJoinRound: true,
                                  spots: data,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    applyCutOffY: true,
                                    color: App.color.tertiary.withAlpha(100),
                                  ),
                                )
                              ],
                              borderData: FlBorderData(
                                border: const Border(),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            size: 20.sp,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Best Recorded',
                            style: App.text.titleMedium!.copyWith(
                              color: App.color.onSurface,
                            ),
                          ),
                        ],
                      ),
                      noData
                          ? Text(
                              "-",
                              style: App.text.bodyMedium!.copyWith(
                                color: App.color.onSurface,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'From ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      highestFrom,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'To ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      highestTo,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'Total ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '$highest',
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Recorded at ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: highestDate,
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Divider(color: App.color.onSurfaceVariant.withAlpha(100)),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_downward_rounded,
                            size: 20.sp,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Poorest Recorded',
                            style: App.text.titleMedium!.copyWith(
                              color: App.color.onSurface,
                            ),
                          ),
                        ],
                      ),
                      noData
                          ? Text(
                              "-",
                              style: App.text.bodyMedium!.copyWith(
                                color: App.color.onSurface,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'From ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lowestFrom,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'To ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lowestTo,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'Total ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      lowest,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Recorded at ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      TextSpan(
                                        text: lowestDate,
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Divider(color: App.color.onSurfaceVariant.withAlpha(100)),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 20.sp,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Average',
                            style: App.text.titleMedium!.copyWith(
                              color: App.color.onSurface,
                            ),
                          ),
                        ],
                      ),
                      noData
                          ? Text(
                              "-",
                              style: App.text.bodyMedium!.copyWith(
                                color: App.color.onSurface,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        'Total ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      average,
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

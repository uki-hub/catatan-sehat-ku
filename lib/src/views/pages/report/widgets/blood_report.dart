import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/models/blood_pressure_model.dart';
import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class BloodReport extends StatelessWidget {
  const BloodReport({super.key});

  Map<String, dynamic> analyzeBloodPressureRecords(List<BloodPressureRecordModel> records) {
    if (records.isEmpty) {
      return {
        'highest': {'sys': 0, 'dia': 0, 'pulse': 0, 'recordDate': null},
        'lowest': {'sys': 0, 'dia': 0, 'pulse': 0, 'recordDate': null},
        'average': {'sys': 0.0, 'dia': 0.0, 'pulse': 0.0},
      };
    }

    BloodPressureRecordModel highestRecord = records.first;
    BloodPressureRecordModel lowestRecord = records.first;

    int totalSys = 0;
    int totalDia = 0;
    int totalPulse = 0;

    for (var record in records) {
      totalSys += record.sys;
      totalDia += record.dia;
      totalPulse += record.pulse;

      if (record.sys > highestRecord.sys) highestRecord = record;

      if (record.sys < lowestRecord.sys) lowestRecord = record;
    }

    final averageSys = totalSys / records.length;
    final averageDia = totalDia / records.length;
    final averagePulse = totalPulse / records.length;

    return {
      'highest': {
        'sys': highestRecord.sys,
        'dia': highestRecord.dia,
        'pulse': highestRecord.pulse,
        'recordDate': highestRecord.recordDate,
      },
      'lowest': {
        'sys': lowestRecord.sys,
        'dia': lowestRecord.dia,
        'pulse': lowestRecord.pulse,
        'recordDate': lowestRecord.recordDate,
      },
      'average': {
        'sys': averageSys,
        'dia': averageDia,
        'pulse': averagePulse,
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BloodPressureRecorderCubit, BloodPressureRecorderState>(
      builder: (context, state) {
        final cubit = context.read<BloodPressureRecorderCubit>();

        final noData = state.records.isEmpty;

        final sysData = cubit.generateChartDataForHIghest(state.records);
        final ldlData = cubit.generateChartDataForLowest(state.records);

        final analyzed = analyzeBloodPressureRecords(state.records);

        final highest = analyzed["highest"];
        final lowest = analyzed["highest"];
        final average = analyzed["highest"];

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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: App.color.surfaceContainerHigh),
              child: Text(
                "Blood Pressure",
                style: App.text.titleMedium!.copyWith(color: App.color.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
            collapsed: const SizedBox(),
            expanded: Container(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
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
                                  color: Colors.red[700],
                                  // isStrokeJoinRound: true,
                                  spots: sysData,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    applyCutOffY: true,
                                    color: Colors.red[700]!.withAlpha(100),
                                  ),
                                ),
                                LineChartBarData(
                                  isCurved: true,
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: false),
                                  color: Colors.blue[800],
                                  // isStrokeJoinRound: true,
                                  spots: ldlData,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    applyCutOffY: true,
                                    color: Colors.blue[800]!.withAlpha(100),
                                  ),
                                )
                              ],
                              borderData: FlBorderData(border: const Border()),
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
                            'Highest Recorded',
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
                                        'SYS',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${highest['sys']} mg/dL',
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
                                        'DIA',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${highest['dia']} mg/dL',
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
                                        'Pulse',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${highest['pulse']} Bpm',
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
                                        text: DateFormat('dd MMM yyyy hh:mm a').format(highest['recordDate']),
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
                            'Lowest Recorded',
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
                                        'SYS',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${lowest['sys']} mg/dL',
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
                                        'DIA',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${lowest['dia']} mg/dL',
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
                                        'Pulse',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${lowest['pulse']} Bpm',
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
                                        text: DateFormat('dd MMM yyyy hh:mm a').format(lowest['recordDate']),
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
                                        'SYS',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${average["sys"]} mg/dL',
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
                                        'DIA',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${average["dia"]} mg/dL',
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
                                        'Pulse',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${average["pulse"]} Bpm',
                                      style: App.text.bodyMedium!.copyWith(
                                        color: App.color.onSurface,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
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

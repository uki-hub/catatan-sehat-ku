import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/models/cholesterol_model.dart';
import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CholesterolReport extends StatelessWidget {
  const CholesterolReport({super.key});

  double calculateTotalCholesterol(double hdl, double ldl, double triglycerides) {
    return hdl + ldl + (triglycerides / 5);
  }

  Map<String, dynamic> analyzeCholesterolRecords(List<CholesterolRecordModel> records, double triglycerides) {
    if (records.isEmpty) {
      return {
        'highest': {'totalCholesterol': 0.0, 'hdl': 0.0, 'ldl': 0.0, 'recordDate': null},
        'lowest': {'totalCholesterol': 0.0, 'hdl': 0.0, 'ldl': 0.0, 'recordDate': null},
        'average': {'totalCholesterol': 0.0, 'hdl': 0.0, 'ldl': 0.0},
      };
    }

    CholesterolRecordModel highestRecord = records.first;
    CholesterolRecordModel lowestRecord = records.first;

    double totalCholesterolSum = 0.0;
    double totalHdlSum = 0.0;
    double totalLdlSum = 0.0;

    for (var record in records) {
      final totalCholesterol = calculateTotalCholesterol(record.hdl, record.ldl, triglycerides);

      totalCholesterolSum += totalCholesterol;
      totalHdlSum += record.hdl;
      totalLdlSum += record.ldl;

      if (totalCholesterol > calculateTotalCholesterol(highestRecord.hdl, highestRecord.ldl, triglycerides)) {
        highestRecord = record;
      }
      if (totalCholesterol < calculateTotalCholesterol(lowestRecord.hdl, lowestRecord.ldl, triglycerides)) {
        lowestRecord = record;
      }
    }

    final averageTotalCholesterol = totalCholesterolSum / records.length;
    final averageHdl = totalHdlSum / records.length;
    final averageLdl = totalLdlSum / records.length;

    return {
      'highest': {
        'total': calculateTotalCholesterol(highestRecord.hdl, highestRecord.ldl, triglycerides),
        'hdl': highestRecord.hdl,
        'ldl': highestRecord.ldl,
        'recordDate': highestRecord.recordDate,
      },
      'lowest': {
        'total': calculateTotalCholesterol(lowestRecord.hdl, lowestRecord.ldl, triglycerides),
        'hdl': lowestRecord.hdl,
        'ldl': lowestRecord.ldl,
        'recordDate': lowestRecord.recordDate,
      },
      'average': {
        'total': averageTotalCholesterol,
        'hdl': averageHdl,
        'ldl': averageLdl,
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CholesterolRecorderCubit, CholesterolRecorderState>(
      builder: (context, state) {
        final cubit = context.read<CholesterolRecorderCubit>();

        final noData = state.records.isEmpty;

        final hdlData = cubit.generateChartDataForHIghest(state.records);
        final ldlData = cubit.generateChartDataForLowest(state.records);

        final analyzed = analyzeCholesterolRecords(state.records, 150);
        
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
                "Cholesterol",
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
                                  color: Colors.yellow[500],
                                  // isStrokeJoinRound: true,
                                  spots: hdlData,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    applyCutOffY: true,
                                    color: Colors.yellow[700]!.withAlpha(100),
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
                                        'HDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(highest['hdl'])} mg/dL',
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
                                        'LDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(highest['ldl'])} mg/dL',
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
                                      '${Common.formatDouble(highest['total'])} mg/dL',
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
                                        'HDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(lowest['hdl'])} mg/dL',
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
                                        'LDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(lowest['ldl'])} mg/dL',
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
                                      '${Common.formatDouble(lowest['total'])} mg/dL',
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
                                        'HDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(average['hdl'])} mg/dL',
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
                                        'LDL ',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(average['ldl'])} mg/dL',
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
                                        'Total',
                                        style: App.text.bodyMedium!.copyWith(
                                          color: App.color.onSurface,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Common.formatDouble(average['total'])} mg/dL',
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

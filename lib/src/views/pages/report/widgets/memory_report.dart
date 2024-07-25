import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MemoryReport extends StatelessWidget {
  const MemoryReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final cubit = context.read<GameCubit>();

        final data = cubit.generateChartData(state.records);
        final noData = data.isEmpty;

        final records = [...state.records];

        records.sort((a, b) => a.totalSeconds.compareTo(b.totalSeconds));

        final highest = records.lastOrNull;

        final lowest = records.firstOrNull;

        final average = (state.records.fold(0.0, (sum, record) => sum + record.totalSeconds)) / state.records.length;

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
                "Memory",
                style: App.text.titleMedium!.copyWith(color: App.color.onSurface, fontWeight: FontWeight.w600),
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
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Finished ',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${lowest!.totalSeconds} Seconds',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' at ',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: DateFormat('dd MMM yyyy hh:mm a').format(lowest.recordDate),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Finished ',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${highest!.totalSeconds} Seconds',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' at ',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: DateFormat('dd MMM yyyy hh:mm a').format(highest.recordDate),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
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
                          : Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Weighted ',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${Common.formatDouble(average)}KG',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
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

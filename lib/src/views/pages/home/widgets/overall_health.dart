import 'dart:math';

import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:catatan_sehat_ku/src/views/widgets/blood_pressure_chart.dart';
import 'package:catatan_sehat_ku/src/views/widgets/cholesterol_chart.dart';
import 'package:catatan_sehat_ku/src/views/widgets/memory_chart.dart';
import 'package:catatan_sehat_ku/src/views/widgets/sleep_chart.dart';
import 'package:catatan_sehat_ku/src/views/widgets/weight_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverallHealth extends StatelessWidget {
  const OverallHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 10),
      decoration: BoxDecoration(
        color: App.color.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Uki Health's in this Week",
            textAlign: TextAlign.center,
            style: App.text.titleLarge!.copyWith(color: App.color.primary),
          ),
          const SizedBox(height: 10),
          BlocBuilder<BloodPressureRecorderCubit, BloodPressureRecorderState>(
            builder: (context, state) {
              final cubit = context.read<BloodPressureRecorderCubit>();

              final weekData = cubit.getWeeklyReport();
              final score = cubit.getScore(records: weekData);

              return HealthRow(
                noData: weekData.isEmpty,
                label: "Blood Pressure",
                score: Common.formatDouble(score),
                chart: BloodPressureChart(
                  highest: cubit.generateChartDataForHIghest(weekData),
                  lowest: cubit.generateChartDataForLowest(weekData),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Divider(color: App.color.surfaceDim),
          const SizedBox(height: 5),
          BlocBuilder<WeightRecorderCubit, WeightRecorderState>(
            builder: (context, state) {
              final cubit = context.read<WeightRecorderCubit>();

              final weekData = cubit.getWeeklyReport();
              final score = cubit.getScore(records: weekData);

              return HealthRow(
                noData: weekData.isEmpty,
                label: "Weight",
                score: Common.formatDouble(score),
                chart: WeightChart(
                  data: cubit.generateChartData(weekData),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Divider(color: App.color.surfaceDim),
          const SizedBox(height: 5),
          BlocBuilder<SleepRecorderCubit, SleepRecorderState>(
            builder: (context, state) {
              final cubit = context.read<SleepRecorderCubit>();

              final weekData = cubit.getWeeklyReport();
              final score = cubit.getScore(records: weekData);

              return HealthRow(
                noData: weekData.isEmpty,
                label: "Sleep",
                score: Common.formatDouble(score),
                chart: SleepChart(
                  data: cubit.generateChartData(weekData),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Divider(color: App.color.surfaceDim),
          const SizedBox(height: 5),
           BlocBuilder<CholesterolRecorderCubit, CholesterolRecorderState>(
            builder: (context, state) {
              final cubit = context.read<CholesterolRecorderCubit>();

              final weekData = cubit.getWeeklyReport();
              final score = cubit.getScore(records: weekData);

              return HealthRow(
                noData: weekData.isEmpty,
                label: "Cholesterol",
                score: Common.formatDouble(score),
                chart: CholesterolChart(
                  highest: cubit.generateChartDataForHIghest(weekData),
                  lowest: cubit.generateChartDataForLowest(weekData),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Divider(color: App.color.surfaceDim),
          const SizedBox(height: 5),
           BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              final cubit = context.read<GameCubit>();

              final weekData = cubit.getWeeklyReport();
              final score = cubit.getScore(records: weekData);

              return HealthRow(
                noData: weekData.isEmpty,
                label: "Memory",
                score: Common.formatDouble(score),
                chart: MemoryChart(
                  data: cubit.generateChartData(weekData),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class HealthRow extends StatelessWidget {
  final bool noData;
  final String label;
  final String score;
  final Widget chart;

  const HealthRow({
    super.key,
    required this.noData,
    required this.label,
    required this.score,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: App.text.titleSmall!.copyWith(color: App.color.secondary),
        ),
        ...(noData
            ? [
                Text(
                  "No Recorded Data Found",
                  style: App.text.bodyMedium!.copyWith(color: App.color.primaryContainer.withAlpha(200)),
                )
              ]
            : [
                const Spacer(),
                Text(
                  score,
                  style: App.text.titleLarge!.copyWith(
                    color: App.color.tertiary,
                  ),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: 120.w,
                  height: 50,
                  child: chart,
                )
              ]),
      ],
    );
  }
}

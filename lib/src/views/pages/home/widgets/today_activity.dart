import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayActivity extends StatelessWidget {
  const TodayActivity({super.key});

  bool isSameDate(DateTime dateTime1, DateTime dateTime2) {
    return dateTime1.year == dateTime2.year && dateTime1.month == dateTime2.month && dateTime1.day == dateTime2.day;
  }

  @override
  Widget build(BuildContext context) {
    final weightCubit = context.watch<WeightRecorderCubit>();
    final bloodCubit = context.watch<BloodPressureRecorderCubit>();
    final sleepCubit = context.watch<SleepRecorderCubit>();
    final cholesterolCubit = context.watch<CholesterolRecorderCubit>();

    final weightLastRecord = weightCubit.state.records.lastOrNull;
    final bloodLastRecord = bloodCubit.state.records.lastOrNull;
    final sleepLastRecord = sleepCubit.state.records.lastOrNull;
    final cholesterolLastRecord = cholesterolCubit.state.records.lastOrNull;

    final today = DateTime.now();

    final showWeight = (weightLastRecord == null) || !isSameDate(weightLastRecord.recordDate, today);
    final showBlood = (bloodLastRecord == null) || !isSameDate(bloodLastRecord.recordDate, today);
    final showSleep = (sleepLastRecord == null) || !isSameDate(sleepLastRecord.recordDate, today);
    final showCholestrol = (cholesterolLastRecord == null) || !isSameDate(cholesterolLastRecord.recordDate, today);
    final showHealthy = [showWeight, showBlood, showSleep, showCholestrol].any((e) => false);

    final percentage = ([showWeight, showBlood, showSleep, showCholestrol].where((value) => value == false).length / 4) * 100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
      decoration: BoxDecoration(
        color: App.color.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Today Activity",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.tertiary),
            ),
          ),
          Divider(color: App.color.surfaceDim),
          ...(showHealthy
              ? [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "No Task :)",
                        style: App.text.bodyMedium!.copyWith(
                          color: App.color.tertiary,
                        ),
                      ),
                    ),
                  )
                ]
              : [
                  Text(
                    "To do",
                    style: App.text.bodyMedium!.copyWith(
                      color: App.color.tertiaryContainer.withAlpha(125),
                    ),
                  ),
                  const SizedBox(height: 5),
                  showWeight ? const TodayActivityRow(label: "Weight", route: "/health/record-weight",) : const SizedBox(),
                  showBlood ? const TodayActivityRow(label: "Blood Pressure", route: "/health/record-blood-pressure") : const SizedBox(),
                  showSleep ? const TodayActivityRow(label: "Sleep", route: "/health/record-sleep") : const SizedBox(),
                  showCholestrol ? const TodayActivityRow(label: "Cholesterol", route: "/health/record-cholesterol") : const SizedBox(),
                ]),
          Divider(color: App.color.surfaceDim),
          Center(
            child: Text(
              "${Common.formatDouble(percentage)}%",
              style: App.text.headlineLarge!.copyWith(
                color: App.color.tertiary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TodayActivityRow extends StatelessWidget {
  final String label;
  final String route;

  const TodayActivityRow({
    super.key,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: App.text.bodyMedium!.copyWith(
                color: App.color.tertiary,
              ),
            ),
            GestureDetector(
              onTap: () => App.to(route),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: App.color.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

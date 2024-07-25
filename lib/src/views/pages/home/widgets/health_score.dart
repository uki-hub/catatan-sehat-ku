import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HealthScore extends StatelessWidget {
  const HealthScore({super.key});

  @override
  Widget build(BuildContext context) {
    final weightCubit = context.watch<WeightRecorderCubit>();
    final bloodCubit = context.watch<BloodPressureRecorderCubit>();
    final sleepCubit = context.watch<SleepRecorderCubit>();
    final cholesterolCubit = context.watch<CholesterolRecorderCubit>();

    final weightScore = weightCubit.getScore();
    final bloodScore = bloodCubit.getScore();
    final sleepScore = sleepCubit.getScore();
    final cholesterolScore = cholesterolCubit.getScore();

    final overallRating = (weightScore + bloodScore + sleepScore + cholesterolScore) / 4.0;
    final overallPercentage = overallRating / 10;

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
              "Health",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.primary),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => App.to("/health"),
                child: Text(
                  "   More",
                  style: App.text.bodySmall!.copyWith(color: App.color.primaryContainer),
                ),
              ),
              Icon(
                Icons.navigate_next_rounded,
                color: App.color.primaryContainer,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80.h,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: CircularPercentIndicator(
                radius: 0.14.sw,
                lineWidth: 8,
                animation: true,
                arcType: ArcType.HALF,
                percent: overallPercentage,
                arcBackgroundColor: App.color.surfaceDim,
                startAngle: 270,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: App.color.primaryContainer,
                center: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Common.formatDouble(overallRating),
                      style: App.text.headlineLarge!.copyWith(color: App.color.primaryContainer),
                    ),
                    Text(
                      Common.scoringLabel(overallRating),
                      style: App.text.labelMedium!.copyWith(color: App.color.primaryContainer),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

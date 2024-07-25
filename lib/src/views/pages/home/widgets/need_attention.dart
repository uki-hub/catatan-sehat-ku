import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NeedAttention extends StatelessWidget {
  const NeedAttention({super.key});

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

    final showWeight = weightScore < 3;
    final showBlood = bloodScore < 3;
    final showSleep = sleepScore < 3;
    final showCholestrol = cholesterolScore < 3;
    final showHealthy = [showWeight, showBlood, showSleep, showCholestrol].any((e) => false);

    final tiles = <Widget>[];
    if (showWeight) tiles.add(HealthTile(route: "/health/record-weight", label: "Weight", score: Common.formatDouble(weightScore), icon: FontAwesomeIcons.weightScale));
    if (showBlood) tiles.add(HealthTile(route: "/health/record-blood-pressure", label: "Blood Pressure", score: Common.formatDouble(bloodScore), icon: FontAwesomeIcons.droplet));
    if (showSleep) tiles.add(HealthTile(route: "/health/record-sleep", label: "Sleep", score: Common.formatDouble(sleepScore), icon: FontAwesomeIcons.bed));
    if (showCholestrol) tiles.add(HealthTile(route: "/health/record-cholesterol", label: "Cholesterol", score: Common.formatDouble(cholesterolScore), icon: Icons.favorite));

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
              "Needs Attention",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.tertiaryContainer),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            // height: 100,
            width: double.infinity,
            child: showHealthy
                ? Text(
                    "You Good :)",
                    textAlign: TextAlign.center,
                    style: App.text.bodySmall!.copyWith(
                      color: App.color.tertiary,
                    ),
                  )
                : GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: .9,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 7,
                    children: tiles,
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class HealthTile extends StatelessWidget {
  final String route;
  final String label;
  final String score;
  final IconData icon;

  const HealthTile({
    super.key,
    required this.route,
    required this.label,
    required this.score,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => App.to(route),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: App.color.surfaceDim,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: App.color.tertiary,
                size: 24.sp,
              ),
              const SizedBox(height: 5),
              // Text(
              //   label,
              //   textAlign: TextAlign.center,
              //   style: App.text.bodySmall!.copyWith(
              //     color: App.color.tertiary,
              //   ),
              // ),
              Text(
                score,
                style: App.text.bodySmall!.copyWith(
                  color: App.color.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/health_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const _menu = [
  "/health/record-weight",
  "/health/record-blood-pressure",
  "/health/record-sleep",
  "/health/record-cholesterol",
  "/health/record-memory",
];

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weightCubit = context.watch<WeightRecorderCubit>();
    final bloodCubit = context.watch<BloodPressureRecorderCubit>();
    final sleepCubit = context.watch<SleepRecorderCubit>();
    final cholesterolCubit = context.watch<CholesterolRecorderCubit>();
    final gameCubit = context.watch<GameCubit>();

    final weightScore = weightCubit.getScore();
    final bloodScore = bloodCubit.getScore();
    final sleepScore = sleepCubit.getScore();
    final cholesterolScore = cholesterolCubit.getScore();

    final overallRating = (weightScore + bloodScore + sleepScore + cholesterolScore) / 4.0;
    final overallPercentage = overallRating / 10;

    final weightLastRecorded = weightCubit.state.records.lastOrNull?.recordDate;
    final bloodLastRecorded = bloodCubit.state.records.lastOrNull?.recordDate;
    final sleepLastRecorded = sleepCubit.state.records.lastOrNull?.recordDate;
    final cholesterolLastRecorded = cholesterolCubit.state.records.lastOrNull?.recordDate;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              SizedBox(
                height: 160.h,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: CircularPercentIndicator(
                    radius: 0.35.sw,
                    lineWidth: 24,
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
                          style: App.text.displayMedium!.copyWith(
                            color: App.color.primaryContainer,
                          ),
                        ),
                        Text(
                          Common.scoringLabel(overallRating),
                          style: App.text.headlineMedium!.copyWith(
                            color: App.color.primaryContainer,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: .75,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                  children: _menu.map((route) {
                    switch (route) {
                      case "/health/record-weight":
                        return HealthCard(
                          route: route,
                          title: "Weight",
                          rating: Common.formatDouble(weightScore),
                          lastRecorded: weightLastRecorded,
                          icon: FontAwesomeIcons.weightScale,
                          iconColor: Colors.teal[800]!,
                        );

                      case "/health/record-blood-pressure":
                        return HealthCard(
                          route: route,
                          title: "Blood",
                          rating: Common.formatDouble(bloodScore),
                          lastRecorded: bloodLastRecorded,
                          icon: FontAwesomeIcons.droplet,
                          iconColor: Colors.red,
                        );

                      case "/health/record-sleep":
                        return HealthCard(
                          route: route,
                          title: "Sleep",
                          rating: Common.formatDouble(sleepScore),
                          lastRecorded: sleepLastRecorded,
                          icon: FontAwesomeIcons.bed,
                          iconColor: Colors.blueGrey[600]!,
                        );

                      case "/health/record-cholesterol":
                        return HealthCard(
                          route: route,
                          title: "Cholesterol",
                          rating: Common.formatDouble(cholesterolScore),
                          lastRecorded: cholesterolLastRecorded,
                          icon: Icons.favorite,
                          iconColor: Colors.red[900]!,
                        );

                      case "/health/record-memory":
                        return HealthCard(
                          route: route,
                          title: "Memory",
                          rating: Common.formatDouble(gameCubit.getScore()),
                          lastRecorded: cholesterolLastRecorded,
                          icon: FontAwesomeIcons.brain,
                          iconColor: Colors.blue[400]!,
                        );
                    }

                    return const SizedBox();
                  }).toList(),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

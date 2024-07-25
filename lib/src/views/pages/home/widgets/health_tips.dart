import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/health_tips_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HealthTips extends StatelessWidget {
  const HealthTips({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Health Tips",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.secondaryContainer),
            ),
          ),
          Divider(color: App.color.surfaceDim),
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              return Text(
                state.healthTips[state.currentIndex],
                textAlign: TextAlign.center,
                style: App.text.bodySmall!.copyWith(color: App.color.tertiary),
              );
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: context.read<HealthTipsCubit>().getRandomHealthTip,
            child: Text(
              "More Tips",
              style: App.text.labelLarge!.copyWith(color: App.color.secondaryFixed),
            ),
          ),
        ],
      ),
    );
  }
}

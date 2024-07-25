import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/views/pages/home/widgets/health_score.dart';
import 'package:catatan_sehat_ku/src/views/pages/home/widgets/health_tips.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import 'widgets/box_suggestion.dart';
import 'widgets/health_record.dart';
import 'widgets/memory_test.dart';
import 'widgets/need_attention.dart';
import 'widgets/overall_health.dart';
import 'widgets/steps_record.dart';
import 'widgets/today_activity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: App.color.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Halo, ",
                          style: App.text.headlineLarge!.copyWith(
                            color: App.color.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email!.split('@')[0],
                          style: App.text.headlineLarge!.copyWith(
                            color: App.color.primary, // Set the color of "Uki" to blue
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "\nSelamat Datang",
                          style: App.text.headlineMedium!.copyWith(
                            color: App.color.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TodayActivity(),
                          SizedBox(height: 15),
                          HealthTips(),
                          SizedBox(height: 15),
                          HealthRecord(),
                          SizedBox(height: 15),
                          MemoryTest(),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: [
                          HealthScore(),
                          SizedBox(height: 15),
                          NeedAttention(),
                          SizedBox(height: 15),
                          StepsRecord(),
                          SizedBox(height: 15),
                          BoxSuggestion(),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                const OverallHealth(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

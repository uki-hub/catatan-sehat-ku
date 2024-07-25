import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/widgets/blood_report.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/widgets/cholesterol_report.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/widgets/memory_report.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/widgets/sleep_report.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/widgets/weight_report.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Health Report',
                style: App.text.headlineLarge!.copyWith(
                  color: App.color.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Report for all records',
                style: App.text.bodyMedium!.copyWith(
                  color: App.color.onSurface.withAlpha(150),
                ),
              ),
              const SizedBox(height: 20),
              const WeightReport(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: App.color.onSurfaceVariant.withAlpha(50)),
              ),
              const SleepReport(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: App.color.onSurfaceVariant.withAlpha(50)),
              ),
              const BloodReport(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: App.color.onSurfaceVariant.withAlpha(50)),
              ),
              const CholesterolReport(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: App.color.onSurfaceVariant.withAlpha(50)),
              ),
              const MemoryReport(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

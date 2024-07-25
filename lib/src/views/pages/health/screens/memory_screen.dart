import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:catatan_sehat_ku/src/models/blood_pressure_model.dart';
import 'package:catatan_sehat_ku/src/models/weight_record_model.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/field_row.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/record_history.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {

  void recordHandler() {
    App.to("/game");
  }

  @override
  Widget build(BuildContext context) {
    final lastData = context.read<GameCubit>().state.records.lastOrNull;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Memory',
          style: App.text.titleLarge!.copyWith(
            color: App.color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: recordHandler,
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: App.color.tertiaryContainer,
                    border: Border.all(
                      color: App.color.primary,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.play,
                        color: App.color.onTertiaryContainer,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Play Game",
                        textAlign: TextAlign.center,
                        style: App.text.bodyMedium!.copyWith(
                          color: App.color.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                final orderedRecords = [...state.records]..sort((a, b) => b.recordDate.compareTo(a.recordDate));

                return RecordHistory(
                  records: orderedRecords,
                  rowBuilder: (context, index, data) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      margin: EdgeInsets.only(bottom: index == 9 ? 20 : 0),
                      decoration: BoxDecoration(
                        color: App.color.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: App.color.onSurfaceVariant.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            Common.formatDateTime(data.recordDate),
                            style: App.text.titleSmall!.copyWith(
                              color: App.color.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Divider(color: App.color.onSurface.withAlpha(50)),
                          Text(
                            '${data.totalSeconds.toString()} Seconds',
                            style: App.text.titleSmall!.copyWith(
                              color: App.color.onSurface,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

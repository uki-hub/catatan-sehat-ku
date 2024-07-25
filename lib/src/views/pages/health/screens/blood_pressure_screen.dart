import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/models/blood_pressure_model.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/field_row.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/record_history.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final sysController = TextEditingController();
  final diaController = TextEditingController();
  final pulseController = TextEditingController();

  void recordHandler() {
    FocusManager.instance.primaryFocus?.unfocus();

    final cubit = context.read<BloodPressureRecorderCubit>();

    cubit.record(
      BloodPressureRecordModel(
        sys: int.parse(sysController.text),
        dia: int.parse(diaController.text),
        pulse: int.parse(pulseController.text),
        recordDate: DateTime.now(),
      ),
    );

    sysController.clear();
    diaController.clear();
    pulseController.clear();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lastData = context.read<BloodPressureRecorderCubit>().state.records.lastOrNull;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Record Blood Pressure',
          style: App.text.titleLarge!.copyWith(
            color: App.color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: App.color.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Common.formatDateTime(DateTime.now()),
                        style: App.text.bodyMedium!.copyWith(
                          color: App.color.onSurface,
                        ),
                      ),
                      const SizedBox(height: 15),
                      FieldRow(
                        controller: sysController,
                        title: "SYS",
                        metric: "mmHg",
                        hint: lastData?.sys.toString() ?? '120',
                      ),
                      const SizedBox(height: 20),
                      FieldRow(
                        controller: diaController,
                        title: "DIA",
                        metric: "mmHg",
                        hint: lastData?.dia.toString() ?? '80',
                      ),
                      const SizedBox(height: 20),
                      FieldRow(
                        controller: pulseController,
                        title: "Pulse",
                        metric: "BPM",
                        hint: lastData?.pulse.toString() ?? '75',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: recordHandler,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: App.color.primaryContainer,
                          border: Border.all(
                            color: App.color.primary,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.notesMedical,
                              color: App.color.onPrimary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Record",
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: App.color.tertiaryContainer,
                        border: Border.all(
                          color: App.color.tertiary,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_rounded,
                            color: App.color.onPrimary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Reminder",
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
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<BloodPressureRecorderCubit, BloodPressureRecorderState>(
              builder: (context, state) {
                final orderedRecords = [...state.records]..sort((a, b) => b.recordDate.compareTo(a.recordDate));

                return RecordHistory<BloodPressureRecordModel>(
                  records: orderedRecords,
                  rowBuilder: (context, index, record) {
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
                            Common.formatDateTime(record.recordDate),
                            style: App.text.bodyMedium!.copyWith(
                              color: App.color.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Divider(color: App.color.onSurface.withAlpha(50)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'SYS',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    record.sys.toString(),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'DIA',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    record.dia.toString(),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'PULSE (Bpm)',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    record.pulse.toString(),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
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

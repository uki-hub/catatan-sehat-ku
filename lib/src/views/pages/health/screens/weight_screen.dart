import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
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

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final weightController = TextEditingController();

  void recordHandler() {
    FocusManager.instance.primaryFocus?.unfocus();

    final cubit = context.read<WeightRecorderCubit>();

    cubit.record(
      WeightRecordModel(
        weight: double.parse(weightController.text),
        recordDate: DateTime.now(),
      ),
    );

    weightController.clear();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lastData = context.read<WeightRecorderCubit>().state.records.lastOrNull;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Record Weight',
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
                        controller: weightController,
                        title: "Weight",
                        metric: "KG",
                        hint: Common.formatDouble(lastData?.weight ?? 70, fixedDecimalPlaces: 2),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
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
            const SizedBox(height: 20),
            BlocBuilder<WeightRecorderCubit, WeightRecorderState>(
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
                            '${Common.formatDouble(data.weight)} KG',
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

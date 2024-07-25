import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/models/sleep_record_model.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/record_history.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final DateTime recordDate = DateTime.now();

  late TextEditingController fromHourController;
  late TextEditingController fromMinuteController;
  late String initialFromPeriod;
  late String fromPeriod;

  late TextEditingController toHourController;
  late TextEditingController toMinuteController;
  late String initialToPeriod;
  late String toPeriod;

  late DateTime dateOfSleep;

  DateTime convertToDateTime(String hour, String minute, String periodType, DateTime date) {
    int parsedHour = int.parse(hour);
    int parsedMinute = int.parse(minute);

    if (periodType == 'PM' && parsedHour != 12) {
      parsedHour += 12;
    } else if (periodType == 'AM' && parsedHour == 12) {
      parsedHour = 0;
    }

    return DateTime(date.year, date.month, date.day, parsedHour, parsedMinute);
  }

  @override
  void initState() {
    final fromTime = DateTime.now();
    int fromHour = fromTime.hour;

    fromPeriod = fromHour >= 12 ? 'PM' : 'AM';
    initialFromPeriod = fromPeriod;

    fromHour = fromHour % 12;
    if (fromHour == 0) fromHour = 12;

    final toTime = fromTime.add(const Duration(hours: 8));
    int toHour = toTime.hour;

    toPeriod = toHour >= 12 ? 'PM' : 'AM';
    initialToPeriod = toPeriod;

    toHour = toHour % 12;
    if (toHour == 0) toHour = 12;

    fromHourController = TextEditingController(text: Common.timeFormat(fromHour));
    fromMinuteController = TextEditingController(text: Common.timeFormat(fromTime.minute));

    toHourController = TextEditingController(text: Common.timeFormat(toHour));
    toMinuteController = TextEditingController(text: Common.timeFormat(toTime.minute));

    dateOfSleep = DateTime.now();

    super.initState();
  }

  void recordHandler() {
    FocusManager.instance.primaryFocus?.unfocus();

    final cubit = context.read<SleepRecorderCubit>();

    DateTime fromDateTime = convertToDateTime(fromHourController.text, fromMinuteController.text, fromPeriod, dateOfSleep);
    DateTime toDateTime = convertToDateTime(toHourController.text, toMinuteController.text, toPeriod, dateOfSleep);

    if (toDateTime.isBefore(fromDateTime)) toDateTime = toDateTime.add(const Duration(days: 1));

    cubit.record(
      SleepRecordModel(
        from: fromDateTime,
        to: toDateTime,
        dateOfSleep: dateOfSleep,
        recordDate: recordDate,
      ),
    );

    fromHourController.clear();
    fromMinuteController.clear();
    toHourController.clear();
    toMinuteController.clear();
    dateOfSleep = DateTime.now();
    fromPeriod = initialFromPeriod;
    toPeriod = initialToPeriod;

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Record Sleep',
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
                        Common.formatDateTime(recordDate),
                        style: App.text.bodyMedium!.copyWith(
                          color: App.color.onSurface,
                        ),
                      ),
                      const SizedBox(height: 15),
                      FieldRow(
                        title: "From",
                        hourController: fromHourController,
                        minuteController: fromMinuteController,
                        initialValueTimeType: fromPeriod,
                        onTimeTypeChanged: (timeType) => setState(() => (fromPeriod = timeType)),
                      ),
                      const SizedBox(height: 15),
                      FieldRow(
                        title: "To",
                        hourController: toHourController,
                        minuteController: toMinuteController,
                        initialValueTimeType: toPeriod,
                        onTimeTypeChanged: (timeType) => setState(() => (toPeriod = timeType)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Date of Sleep",
                            style: App.text.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: App.color.onSurface,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => App.showBottomSheetDatePicker(context, (selectedDate) {
                              setState(() => (dateOfSleep = selectedDate));
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                              decoration: BoxDecoration(
                                color: App.color.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                DateFormat('dd MMM yyyy').format(dateOfSleep),
                                style: App.text.titleMedium!.copyWith(
                                  color: App.color.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
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
            BlocBuilder<SleepRecorderCubit, SleepRecorderState>(
              builder: (context, state) {
                final orderedRecords = [...state.records]..sort((a, b) => b.recordDate.compareTo(a.recordDate));

                return RecordHistory(
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
                                    'FROM',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("hh:mm a").format(record.from),
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
                                    'TO',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("hh:mm a").format(record.to),
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 35.h,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: VerticalDivider(
                                  thickness: 2,
                                  color: App.color.onSurface.withAlpha(75),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Total Sleep',
                                    style: App.text.bodyMedium!.copyWith(
                                      color: App.color.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${record.to.difference(record.from).inHours.toString()} Hours',
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

class FieldRow extends StatelessWidget {
  final String title;
  final TextEditingController hourController;
  final TextEditingController minuteController;
  final void Function(String timeType) onTimeTypeChanged;
  final String initialValueTimeType;

  const FieldRow({
    super.key,
    required this.title,
    required this.hourController,
    required this.minuteController,
    required this.onTimeTypeChanged,
    required this.initialValueTimeType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: App.text.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: App.color.onSurface,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 35,
            child: TextField(
              controller: hourController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              textAlign: TextAlign.end,
              style: App.text.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: App.color.onSurface,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: hourController.text,
                counterText: "",
                hintStyle: App.text.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: App.color.onSurfaceVariant.withAlpha(125),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              ":",
              style: App.text.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: App.color.onSurfaceVariant.withAlpha(125),
              ),
            ),
          ),
          SizedBox(
            width: 35,
            child: TextField(
              controller: minuteController,
              keyboardType: TextInputType.number,
              maxLength: 2,
              textAlign: TextAlign.end,
              style: App.text.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: App.color.onSurface,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: minuteController.text,
                counterText: "",
                hintStyle: App.text.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: App.color.onSurfaceVariant.withAlpha(125),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          ToggleSwitch(
            customTextStyles: [
              TextStyle(
                color: App.color.onTertiary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              TextStyle(
                color: App.color.onTertiary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ],
            minWidth: 50.w,
            initialLabelIndex: initialValueTimeType == "AM" ? 0 : 1,
            cornerRadius: 12.0,
            activeFgColor: App.color.onTertiary,
            activeBgColor: [App.color.tertiary],
            inactiveFgColor: App.color.onTertiary,
            inactiveBgColor: App.color.tertiary.withAlpha(50),
            totalSwitches: 2,
            labels: const ["AM", "PM"],
            animate: false, // with just animate set to true, default curve = Curves.easeIn
            onToggle: (index) {
              onTimeTypeChanged(index == 0 ? "AM" : "PM");
            },
          ),
        ],
      ),
    );
  }
}

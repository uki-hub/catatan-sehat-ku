import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetDatePicker extends StatelessWidget {
  final void Function(DateTime selectedDate) onSelectedDate;

  const BottomSheetDatePicker({super.key, required this.onSelectedDate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: 1.sw,
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                daySplashColor: Colors.transparent,
              ),
              value: const [],
              onValueChanged: (dates) => onSelectedDate(dates.first),
            ),
          ),
        )
      ],
    );
  }
}

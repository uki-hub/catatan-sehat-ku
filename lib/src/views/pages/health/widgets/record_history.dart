import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordHistory<T> extends StatelessWidget {
  final List<T> records;
  final Widget Function(BuildContext context, int index, T record) rowBuilder;

  const RecordHistory({
    super.key,
    required this.records,
    required this.rowBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                size: 24.sp,
                color: App.color.onSurface,
              ),
              const SizedBox(width: 5),
              Text(
                "History",
                style: App.text.titleMedium!.copyWith(
                  color: App.color.onSurface,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: App.color.onSurface.withAlpha(75),
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: records.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => rowBuilder(context, index, records[index]),
            ),
          ),
        ],
      ),
    );
  }
}

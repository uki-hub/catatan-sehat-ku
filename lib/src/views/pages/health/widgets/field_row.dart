import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldRow extends StatelessWidget {
  final String title;
  final String metric;
  final String hint;
  final TextEditingController controller;

  const FieldRow({
    super.key,
    required this.title,
    required this.metric,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: App.text.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: App.color.onSurface,
                ),
              ),
              Text(
                metric,
                style: App.text.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: App.color.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 130.w,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
              maxLength: 5,
              textAlign: TextAlign.end,
              style: App.text.headlineMedium!.copyWith(
                fontSize: 38.sp,
                fontWeight: FontWeight.w600,
                color: App.color.onSurface,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                hintText: hint,
                counterText: "",
                hintStyle: App.text.headlineMedium!.copyWith(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w600,
                  color: App.color.onSurfaceVariant.withAlpha(125),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

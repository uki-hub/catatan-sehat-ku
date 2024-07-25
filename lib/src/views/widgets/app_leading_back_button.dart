import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLeadingBackButton extends StatelessWidget {
  final bool Function() onTap;

  const AppLeadingBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap()) App.back();
      },
      child: Container(
        color: Colors.transparent,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 24.sp,
          color: App.color.onSurfaceVariant,
        ),
      ),
    );
  }
}

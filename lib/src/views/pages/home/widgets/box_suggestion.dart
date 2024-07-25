import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoxSuggestion extends StatelessWidget {
  const BoxSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
      decoration: BoxDecoration(
        color: App.color.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Box Suggestion",
              textAlign: TextAlign.center,
              style: App.text.titleLarge!.copyWith(color: App.color.tertiaryContainer),
            ),
          ),
          const SizedBox(height: 10),
          Icon(
            FontAwesomeIcons.inbox,
            size: 32.sp,
          ),
          Text(
            "We'd love to hear your feedback!",
            textAlign: TextAlign.center,
            style: App.text.bodySmall!.copyWith(
              color: App.color.tertiary,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: App.color.tertiaryContainer,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              "Suggestion",
              textAlign: TextAlign.center,
              style: App.text.labelLarge!.copyWith(color: App.color.onSecondaryContainer),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

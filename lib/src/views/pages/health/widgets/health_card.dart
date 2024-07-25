import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HealthCard extends StatelessWidget {
  final String route;
  final String title;
  final String rating;
  final DateTime? lastRecorded;
  final IconData icon;
  final Color iconColor;

  const HealthCard({
    super.key,
    required this.route,
    required this.title,
    required this.rating,
    required this.lastRecorded,
    required this.icon,
    required this.iconColor,
  });

  void onTapHandler() {
    App.to(route);
  }

  @override
  Widget build(BuildContext context) {
    String lastRecordedText;

    if (lastRecorded != null) {
      lastRecordedText = 'Last Recorded at\n${DateFormat('dd MMM yyyy hh:mm a').format(lastRecorded!)}';
    } else {
      lastRecordedText = "Nothing has been recorded";
    }

    return GestureDetector(
      onTap: onTapHandler,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: App.color.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: App.text.titleLarge!.copyWith(
                    color: App.color.tertiary,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '/10',
                      style: App.text.bodySmall!.copyWith(
                        color: App.color.tertiary.withAlpha(0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      rating,
                      style: App.text.headlineSmall!.copyWith(
                        color: App.color.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '/10',
                      style: App.text.bodySmall!.copyWith(
                        color: App.color.tertiary.withAlpha(100),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Icon(
                  icon,
                  color: iconColor,
                  size: 64.sp,
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 7),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: Colors.transparent,
                    ),
                    Text(
                      "Record",
                      style: App.text.bodyMedium!.copyWith(
                        color: App.color.primaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: App.color.primaryContainer,
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  lastRecordedText,
                  textAlign: TextAlign.center,
                  style: App.text.bodySmall!.copyWith(
                    color: App.color.tertiaryContainer.withAlpha(175),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

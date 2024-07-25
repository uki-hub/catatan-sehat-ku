import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemoryTest extends StatelessWidget {
  const MemoryTest({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => App.to("/game"),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 10),
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
                "Memory Test",
                textAlign: TextAlign.center,
                style: App.text.titleLarge!.copyWith(color: App.color.primary),
              ),
            ),
            const SizedBox(height: 10),
            Icon(
              FontAwesomeIcons.brain,
              size: 32.sp,
              color: App.color.onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Text(
              "Let's test your memory test by playing game!",
              textAlign: TextAlign.center,
              style: App.text.bodySmall!.copyWith(color: App.color.tertiary),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: App.color.primaryContainer,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                "Play",
                textAlign: TextAlign.center,
                style: App.text.labelLarge!.copyWith(color: App.color.onPrimary),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

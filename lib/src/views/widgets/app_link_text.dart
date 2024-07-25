import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';

class AppLinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AppLinkText({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Text(
          text,
          style: App.text.labelMedium!.copyWith(
            color: App.color.primary,
          ),
        ),
      ),
    );
  }
}

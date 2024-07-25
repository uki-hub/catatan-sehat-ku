import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool expanded;
  final bool rounded;

  const AppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.expanded = true,
    this.rounded = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ? 99 : 7),
          )),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 25, vertical: 15)),
          textStyle: WidgetStateProperty.all(App.text.labelMedium),
          backgroundColor: WidgetStateProperty.all(App.color.primaryContainer),
        ),
        child: child,
      ),
    );
  }
}

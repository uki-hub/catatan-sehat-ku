import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? label;
  final String? hintText;
  final bool isSecret;
  final bool rounded;
  final bool disabled;

  const AppTextField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.hintText,
    this.isSecret = false,
    this.rounded = true,
    this.disabled = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool showSecret;

  @override
  void initState() {
    showSecret = widget.isSecret;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(widget.rounded ? 99 : 7),
      child: TextField(
        controller: widget.controller,
        obscureText: showSecret && widget.isSecret,
        cursorColor: App.color.onSurface,
        style: App.text.bodyMedium!.copyWith(
          color: App.color.onSurface,
          decoration: TextDecoration.none,
        ),
        enabled: !widget.disabled,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          label: widget.label,
          prefixIcon: widget.prefixIcon,
          suffixIcon: !widget.isSecret
              ? const SizedBox()
              : GestureDetector(
                  onTap: () => setState(() => (showSecret = !showSecret)),
                  child: Container(
                    width: 15,
                    height: 15,
                    color: Colors.transparent,
                    child: Icon(
                      showSecret ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      color: App.color.onSurface,
                      size: 18.sp,
                    ),
                  ),
                ),
          hintText: widget.hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(99)),
            borderSide: BorderSide.none,
          ),
          hintStyle: App.text.bodyMedium!.copyWith(
            color: App.color.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

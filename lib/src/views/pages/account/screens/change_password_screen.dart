import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Change Password',
          style: App.text.titleLarge!.copyWith(
            color: App.color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: App.color.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  AppTextField(
                    hintText: "Old Password",
                    rounded: false,
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      size: 18.sp,
                      color: App.color.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    hintText: "New Password",
                    rounded: false,
                    disabled: true,
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      size: 18.sp,
                      color: App.color.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    hintText: "Retype New Password",
                    rounded: false,
                    disabled: true,
                    prefixIcon: Icon(
                      Icons.lock_rounded,
                      size: 18.sp,
                      color: App.color.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AppButton(
              rounded: false,
              onTap: () {},
              child: Text(
                'Change Password',
                style: App.text.titleSmall!.copyWith(color: App.color.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

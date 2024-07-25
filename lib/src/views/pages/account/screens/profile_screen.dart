import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
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
                  SizedBox(
                    width: 100.r,
                    height: 100.r,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipOval(
                            child: Image.asset(
                              "assets/john-doe.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: App.color.secondaryContainer, shape: BoxShape.circle, border: Border.all(color: App.color.onSurface.withAlpha(50))),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 16.sp,
                              color: App.color.onSecondary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppTextField(
                    controller: TextEditingController(
                      text: FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email!.split('@')[0],
                    ),
                    hintText: "Nama",
                    rounded: false,
                    prefixIcon: Icon(
                      Icons.person_2_rounded,
                      size: 18.sp,
                      color: App.color.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: TextEditingController(text: FirebaseAuth.instance.currentUser?.email),
                    hintText: "Email",
                    rounded: false,
                    disabled: true,
                    prefixIcon: Icon(
                      Icons.alternate_email_rounded,
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
                'Save',
                style: App.text.titleSmall!.copyWith(color: App.color.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

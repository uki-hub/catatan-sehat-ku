import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> signOutHandler() async {
    await FirebaseAuth.instance.signOut();

    App.to("/signin");
  }

  Widget accountRow({
    required String route,
    required String label,
    required IconData icon,
    bool showDivider = true,
  }) {
    return GestureDetector(
      onTap: () => App.to(route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 26.sp,
                color: App.color.onSurface,
              ),
              const SizedBox(width: 15),
              Text(
                label,
                style: App.text.bodyMedium!.copyWith(
                  color: App.color.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          showDivider
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: App.color.surfaceDim),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Column(
                children: [
                  Container(
                    width: 100.r,
                    height: 100.r,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: App.color.surfaceContainerHigh,
                      shape: BoxShape.circle,
                      // border: Border.all(color: App.color.onSurface.withAlpha(50))
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/john-doe.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? FirebaseAuth.instance.currentUser!.email!.split('@')[0],
                    style: App.text.titleLarge!.copyWith(
                      color: App.color.onSurface,
                    ),
                  ),
                  Text(
                    "Joined at ${DateFormat('d MMM yyyy').format(DateTime.now())}",
                    style: App.text.bodyMedium!.copyWith(
                      color: App.color.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: App.color.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    accountRow(
                      route: "/account/profile",
                      label: "Profile",
                      icon: Icons.account_circle_outlined,
                    ),
                    accountRow(
                      route: "/account/change-password",
                      label: "Change Password",
                      icon: Icons.lock_outline,
                    ),
                    accountRow(
                      route: "/account/terms",
                      label: "Terms and Conditions",
                      icon: Icons.sticky_note_2_outlined,
                    ),
                    accountRow(
                      route: "/account/setting",
                      label: "Setting",
                      icon: Icons.settings_outlined,
                      showDivider: false,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: signOutHandler,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: App.color.error,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          "Sign Out",
                          textAlign: TextAlign.center,
                          style: App.text.labelLarge!.copyWith(color: App.color.onError),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_cubit.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Setting',
          style: App.text.titleLarge!.copyWith(
            color: App.color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: App.color.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          size: 24.sp,
                          color: App.color.onSurface,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Theme",
                          style: App.text.titleSmall!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: App.color.onSurface.withAlpha(150)),
                    const SizedBox(height: 10),
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        final appCubit = context.read<AppCubit>();

                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(5, (i) {
                            final theme = "Theme ${i+1}";

                            return GestureDetector(
                              onTap: () => appCubit.changeTheme(theme),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(
                                  color: theme == appCubit.state.theme ? App.color.primary : App.color.primaryContainer.withAlpha(200), 
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  theme,
                                  style: App.text.titleSmall!.copyWith(
                                    color: App.color.onPrimary,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          size: 24.sp,
                          color: App.color.onSurface,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Notification",
                          style: App.text.titleSmall!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: App.color.onSurface.withAlpha(150)),
                    Switch(
                      thumbColor: WidgetStatePropertyAll(App.color.primary),
                      activeColor: App.color.primary,
                      value: true,
                      onChanged: (value) => {},
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          size: 24.sp,
                          color: App.color.onSurface,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Account",
                          style: App.text.titleSmall!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: App.color.onSurface.withAlpha(150)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: App.color.error.withAlpha(175),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          "Delete My Account",
                          textAlign: TextAlign.center,
                          style: App.text.labelMedium!.copyWith(color: App.color.onError),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_navigator_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppNavigator extends StatelessWidget {
  final AppNavigatorState state;

  const AppNavigator({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 95,
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25, top: 10),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: App.color.surfaceBright,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: App.color.surfaceDim,
                width: 1,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppNavigatorItem(
                route: "/home",
                label: "Home",
                icon: FontAwesomeIcons.house,
                isActive: state.currentRoute.route == "/home",
              ),
              AppNavigatorItem(
                route: "/health",
                label: "Health",
                icon: true ? FontAwesomeIcons.heartPulse : Icons.diversity_1_rounded,
                isActive: state.currentRoute.route == "/health",
              ),
              AppNavigatorItem(
                route: "/report",
                label: "Status",
                icon: Icons.monitor_heart_rounded,
                isActive: state.currentRoute.route == "/report",
              ),
              AppNavigatorItem(
                route: "/account",
                label: "Account",
                icon: FontAwesomeIcons.solidCircleUser,
                isActive: state.currentRoute.route == "/account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppNavigatorItem extends StatelessWidget {
  final String label;
  final String route;
  final IconData icon;
  final bool isActive;

  const AppNavigatorItem({
    super.key,
    required this.label,
    required this.route,
    required this.icon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => App.to(route),
        child: Container(
          color: Colors.transparent,
          child: AnimatedScale(
            scale: isActive ? 1.15 : 1,
            duration: const Duration(milliseconds: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  size: 20.sp,
                  color: isActive ? App.color.tertiary : App.color.tertiary.withOpacity(0.5),
                ),
                Text(
                  label,
                  style: App.text.labelMedium!.copyWith(
                    color: isActive ? App.color.tertiary : App.color.tertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
    //   builder: (context, state) {
    //     final isActive = state.currentRoute.route == route;

    //     return GestureDetector(
    //       onTap: () => sitesCubit.next(route),
    //       child: Expanded(
    //         child: AnimatedScale(
    //           scale: isActive ? 1.25 : 1,
    //           duration: const Duration(milliseconds: 200),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               FaIcon(
    //                 icon,
    //                 size: 20.sp,
    //               ),
    //               Text(
    //                 label,
    //                 style: App.text.labelMedium!.copyWith(
    //                   color: App.color.primary,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

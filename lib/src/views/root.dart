import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/app/app_router.dart';
import 'package:catatan_sehat_ku/src/app/app_theme.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_navigator_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/auth_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/blood_pressure_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/cholesterol_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/health_tips_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/sleep_recorder_cubit.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/weight_recorder_cubit_cubit.dart';
import 'package:catatan_sehat_ku/src/views/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (context) => AppNavigatorCubit(AppRoutes(route: AppRouter().onGenerateInitialRoutes(context)))),
        BlocProvider(create: (_) => BloodPressureRecorderCubit()),
        BlocProvider(create: (_) => CholesterolRecorderCubit()),
        BlocProvider(create: (_) => SleepRecorderCubit()),
        BlocProvider(create: (_) => WeightRecorderCubit()),
        BlocProvider(create: (_) => HealthTipsCubit()),
        BlocProvider(create: (_) => GameCubit()),
      ],
      child: Builder(
        builder: (context) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, __) {
              return BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Catatan Sehat ku',
                    color: state.themeData.primaryColor,
                    theme: state.themeData,
                    home: PopScope(
                      canPop: false,
                      onPopInvoked: (didpop) async {
                        final navigatorCubit = App.getAppNavigatorCubit;
          
                        if (navigatorCubit.state.routes.length == 2 && (navigatorCubit.state.currentRoute.route == "/signin" || navigatorCubit.state.currentRoute.route == "/home")) {
                          SystemNavigator.pop();
                          return;
                        } else if (navigatorCubit.state.routes.length == 2 && (navigatorCubit.state.currentRoute.route == "/signin" || navigatorCubit.state.currentRoute.route == "/home")) {
                          App.to("/home");
                          return;
                        }
          
                        App.back();
                      },
                      child: Overlay(
                        initialEntries: [
                          OverlayEntry(
                            builder: (context) {
                              return SizedBox(
                                width: 1.sw,
                                height: 1.sh,
                                child: const SafeArea(child: Landing()),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      ),
    );
  }
}

import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/auth_cubit.dart';
import 'package:catatan_sehat_ku/src/views/pages/account/account_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/account/screens/change_password_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/account/screens/profile_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/account/screens/setting_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/account/screens/term_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/game/game_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/health_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/screens/blood_pressure_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/screens/cholesterol_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/screens/memory_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/screens/sleep_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/screens/weight_screen.dart';
import 'package:catatan_sehat_ku/src/views/pages/home/home_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/report/report_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/sign_in/sign_in_page.dart';
import 'package:catatan_sehat_ku/src/views/pages/sign_up/sign_up_page.dart.dart';
import 'package:catatan_sehat_ku/src/views/pages/welcome/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter.__();

  static final AppRouter _ = AppRouter.__();

  factory AppRouter() => _;

  String onGenerateInitialRoutes(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return authCubit.state.signed ? "/home" : "/signin";
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    const router = AppPageRouter();
    final navigatorCubit = App.getAppNavigatorCubit;

    switch (settings.name) {
      case '/welcome':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: true);
        return router.to(const WelcomePage());

      case '/signin':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: true);
        return router.to(const SignInPage());

      case '/signup':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: true);
        return router.to(const SingUpPage());

      case '/home':
        navigatorCubit.to(settings.name!, showBottomBar: true, replace: true);
        return router.to(const HomePage());

      case '/health':
        navigatorCubit.to(settings.name!, showBottomBar: true, replace: true);
        return router.to(const HealthPage());

      case '/health/record-weight':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const WeightScreen());

      case '/health/record-blood-pressure':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const BloodPressureScreen());

      case '/health/record-sleep':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const SleepScreen());

      case '/health/record-cholesterol':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const CholesterolScreen());
      
      case '/health/record-memory':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const MemoryScreen());

      case '/game':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const GamePage());

      case '/report':
        navigatorCubit.to(settings.name!, showBottomBar: true, replace: true);
        return router.to(const ReportPage());

      case '/account':
        navigatorCubit.to(settings.name!, showBottomBar: true, replace: true);
        return router.to(const AccountPage());
      
      case '/account/profile':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const ProfileScreen());
     
      case '/account/change-password':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const ChangePasswordScreen());
     
      case '/account/terms':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const TermScreen());
     
      case '/account/setting':
        navigatorCubit.to(settings.name!, showBottomBar: false, replace: false);
        return router.toCupertino(const SettingScreen());
     
     
      default:
        navigatorCubit.to(settings.name!, showBottomBar: false);
        return router.to(
          GestureDetector(
            onTap: App.back,
            child: const Text('GET BACK TF'),
          ),
        );
    }
  }
}

class AppPageRouter {
  const AppPageRouter();

  Route to(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  Route toCupertino(Widget page) {
    return CupertinoPageRoute(builder: (_) => page);
  }
}

import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/app/app_router.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_navigator_cubit.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final initialRoute = BlocProvider.of<AppNavigatorCubit>(context, listen: false).state.currentRoute;

    final scaffoldKey = GlobalKey<ScaffoldState>();
    final navigatorKey = GlobalKey<NavigatorState>();

    App.init(context, scaffoldKey, navigatorKey);

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Navigator(
              key: navigatorKey,
              initialRoute: initialRoute.route,
              onGenerateRoute: appRouter.onGenerateRoute,
            ),
          ),
          BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
            builder: (context, state) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                bottom: state.currentRoute.showBottomBar ? 0 : -100,
                child: AppNavigator(state: state),
              );
            },
          ),
        ],
      ),
    );
  }
}

part of 'app_navigator_cubit.dart';

class AppNavigatorState extends Equatable {
  final AppRoutes currentRoute;
  final List<AppRoutes> routes;

  const AppNavigatorState({
    required this.currentRoute,
    required this.routes,
  });

  AppNavigatorState copyWith({
    AppRoutes? currentRoute,
    List<AppRoutes>? routes,
    Object? param,
  }) {
    return AppNavigatorState(
      currentRoute: currentRoute ?? this.currentRoute,
      routes: routes ?? this.routes,
    );
  }

  @override
  List<Object> get props => [
        currentRoute,
        routes,
      ];
}

class NavigatorStateInitial extends AppNavigatorState {
  const NavigatorStateInitial(AppRoutes initialRoute)
      : super(
          currentRoute: initialRoute,
          routes: const [],
        );
}

class AppRoutes extends Equatable {
  final String route;
  final bool showBottomBar;
  final Object? param;

  const AppRoutes({required this.route, this.showBottomBar = true, this.param});

  @override
  List<Object> get props => [
        route,
        showBottomBar,
      ];
}

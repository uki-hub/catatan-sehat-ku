import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_navigator_state.dart';

class AppNavigatorCubit extends Cubit<AppNavigatorState> {
  AppNavigatorCubit(AppRoutes initialRoute) : super(NavigatorStateInitial(initialRoute));

  void to(
    String route, {
    bool showBottomBar = true,
    bool replace = false,
  }) {
    final newRoute = AppRoutes(route: route, showBottomBar: showBottomBar);

    final routes = [
      ...(replace ? [state.routes.first] : state.routes),
      newRoute,
    ];

    emit(state.copyWith(
      currentRoute: newRoute,
      routes: routes,
    ));
  }

  void back({String? route}) {
    final routes = [...state.routes];
    routes.removeLast();

    emit(state.copyWith(
      currentRoute: routes.last,
      routes: routes,
    ));
  }
}

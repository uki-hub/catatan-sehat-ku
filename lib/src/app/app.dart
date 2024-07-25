import 'package:catatan_sehat_ku/src/app/app_router.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/app_navigator_cubit.dart';
import 'package:catatan_sehat_ku/src/views/widgets/bottom_sheet_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App {
  static late BuildContext _context; //this context has blocProviders
  static late GlobalKey<ScaffoldState> _scaffold;
  static late GlobalKey<NavigatorState> _navigator;

  static AppNavigatorCubit get getAppNavigatorCubit => BlocProvider.of<AppNavigatorCubit>(_context, listen: false);

  static void init(BuildContext context, GlobalKey<ScaffoldState> scaffold, GlobalKey<NavigatorState> navigator) {
    _context = context;
    _scaffold = scaffold;
    _navigator = navigator;
  }

  static ColorScheme get color => Theme.of(_context).colorScheme;
  static TextTheme get text => Theme.of(_context).textTheme;

  static void to(String route) {
    if (getAppNavigatorCubit.state.routes.last.route == route) return;

    _navigator.currentState!.pushNamed(route);
  }

  static void back({String? route}) {
    _navigator.currentState!.pop();
    getAppNavigatorCubit.back();
  }

  static void showBottomSheetDatePicker(BuildContext context, void Function(DateTime selectedDate) onSelectedDate) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetDatePicker(onSelectedDate: onSelectedDate),
      constraints: BoxConstraints(maxHeight: 0.4.sh),
    );
  }
}

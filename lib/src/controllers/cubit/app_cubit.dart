import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/src/app/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial(theme: "Theme 1", themeData: AppTheme().theme1));

  void changeTheme(String theme) {
    late ThemeData themeData;

    switch (theme) {
      case "Theme 1":
        themeData = AppTheme().theme1;
        break;

      case "Theme 2":
        themeData = AppTheme().theme2;
        break;

      case "Theme 3":
        themeData = AppTheme().theme3;
        break;

      case "Theme 4":
        themeData = AppTheme().theme4;
        break;

      case "Theme 5":
        themeData = AppTheme().theme5;
        break;

      default:
        themeData = AppTheme().theme1;
        break;
    }

    emit(state.copyWith(theme: theme, themeData: themeData));
  }
}

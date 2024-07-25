import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'health_tips_state.dart';

class HealthTipsCubit extends Cubit<HealthTipsState> {
  HealthTipsCubit() : super(HealthTipsInitial()) {
    Timer.periodic(const Duration(minutes: 1), (_) {
      final index = Random().nextInt(20);

      emit(state.copyWith(currentIndex: index));
    });
  }

  String getRandomHealthTip() {
    final index = Random().nextInt(20);

    emit(state.copyWith(currentIndex: index));

    return state.healthTips[index];
  }
}

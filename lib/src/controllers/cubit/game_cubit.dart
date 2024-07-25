import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/base/base_recorder_cubit.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/models/game_record_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:collection/collection.dart'; 


part 'game_state.dart';

class GameCubit extends Cubit<GameState> implements BaseRecorderCubit<GameRecordModel> {
  GameCubit() : super(GameInitial());

  @override
  void clear() {
    // TODO: implement clear
  }

  @override
  List<FlSpot> generateChartData(List<GameRecordModel> data) {
    final result = <FlSpot>[];

    final sortedData = data.toList()..sort((a,b) => b.recordDate.compareTo(a.recordDate));

    for (var i = 0; i < sortedData.length; i++) {
      var d = sortedData[i];

      if (sortedData.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, d.totalSeconds.toDouble()));
        break;
      }

      result.add(FlSpot(i.toDouble(), d.totalSeconds.toDouble()));
    }

    return result;
  }

  @override
  List<GameRecordModel> getDailyReport() {
    final today = DateTime.now();
    return state.records.where((record) => record.recordDate.year == today.year && record.recordDate.month == today.month && record.recordDate.day == today.day).toList();
  }

  @override
  List<GameRecordModel> getMontlyReport() {
    final now = DateTime.now();
    return state.records.where((record) => record.recordDate.year == now.year && record.recordDate.month == now.month).toList();
  }

  @override
  List<GameRecordModel> getPastReport(DateTime from, DateTime to) {
    return state.records.where((record) => record.recordDate.isAfter(from) && record.recordDate.isBefore(to)).toList();
  }

  @override
  GameRecordModel? getPastReportSingle(DateTime date) {
    return state.records.firstWhereOrNull((a) => Common.isDateSame(a.recordDate, date));
  }

  @override
  double getScore({List<GameRecordModel>? records}) {
    records ??= state.records;
    if (records.isEmpty) return 0.0;

    final totalSeconds = records.map((record) => record.totalSeconds).reduce((a, b) => a + b);
    final avgSeconds = totalSeconds / records.length;

    const maxWeight = 150.0; 
    final rating = (avgSeconds / maxWeight) * 10.0;

    return rating.clamp(0.0, 10.0);
  }

  @override
  List<GameRecordModel> getWeeklyReport() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));
    return state.records.where((record) => record.recordDate.isAfter(startOfWeek) && record.recordDate.isBefore(now)).toList();
 
  }

  @override
  void record(GameRecordModel newRecord) {
    final updatedRecords = List<GameRecordModel>.from(state.records)..add(newRecord);
    emit(GameState(records: updatedRecords));
  }
}

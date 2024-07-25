import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/base/base_recorder_cubit.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/models/sleep_record_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:collection/collection.dart';

part 'sleep_recorder_state.dart';

class SleepRecorderCubit extends Cubit<SleepRecorderState> implements BaseRecorderCubit<SleepRecordModel> {
  SleepRecorderCubit() : super(SleepRecorderInitial());

  @override
  void clear() {
    emit(SleepRecorderState(records: []));
  }

  @override
  List<FlSpot> generateChartData(List<SleepRecordModel> data) {
    final result = <FlSpot>[];

    for (var i = 0; i < data.length; i++) {
      var d = data[i];
      var y = d.to.difference(d.from).inHours.toDouble();

      if (data.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, y));
        break;
      }

      result.add(FlSpot(i.toDouble(), y));
    }

    return result;
  }

  @override
  List<SleepRecordModel> getDailyReport() {
    final today = DateTime.now();
    return state.records.where((record) => record.dateOfSleep.year == today.year && record.dateOfSleep.month == today.month && record.dateOfSleep.day == today.day).toList();
  }

  @override
  List<SleepRecordModel> getMontlyReport() {
    final now = DateTime.now();
    return state.records.where((record) => record.dateOfSleep.year == now.year && record.dateOfSleep.month == now.month).toList();
  }

  @override
  List<SleepRecordModel> getPastReport(DateTime from, DateTime to) {
    return state.records.where((record) => record.dateOfSleep.isAfter(from) && record.dateOfSleep.isBefore(to)).toList();
  }

  @override
  SleepRecordModel? getPastReportSingle(DateTime date) {
    return state.records.firstWhereOrNull((a) => Common.isDateSame(a.recordDate, date));
  }

  @override
  double getScore({List<SleepRecordModel>? records}) {
    records ??= state.records;

    if (records.isEmpty) return 0.0;

    final totalDuration = records.fold(0, (sum, record) => sum + record.to.difference(record.from).inHours);
    final averageDuration = totalDuration / records.length.toDouble();

    const maxHours = 8.0;
    final rating = (averageDuration / maxHours) * 10.0;

    return rating.clamp(0.0, 10.0);
  }

  @override
  List<SleepRecordModel> getWeeklyReport() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));
    return state.records.where((record) => record.dateOfSleep.isAfter(startOfWeek) && record.dateOfSleep.isBefore(now)).toList();
  }

  @override
  void record(SleepRecordModel newRecord) {
    final updatedRecords = List<SleepRecordModel>.from(state.records)..add(newRecord);
    emit(SleepRecorderState(records: updatedRecords));
  }
}

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/base/base_recorder_cubit.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/models/blood_pressure_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';

part 'blood_pressure_recorder_state.dart';

class BloodPressureRecorderCubit extends Cubit<BloodPressureRecorderState> implements BaseRecorderCubit<BloodPressureRecordModel> {
  BloodPressureRecorderCubit() : super(BloodPressureRecorderInitial());

  @override
  void clear() {
    emit(BloodPressureRecorderInitial());
  }

  @override
  List<FlSpot> generateChartData(List<BloodPressureRecordModel> data) {
    // TODO: implement getWeeklyReport
    throw UnimplementedError();
  }

  List<FlSpot> generateChartDataForHIghest(List<BloodPressureRecordModel> data) {
    final arr = data.map((e) => e.sys).toList();
    final result = <FlSpot>[];

    for (var i = 0; i < arr.length; i++) {
      final a = arr[i];

      if (data.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, a.toDouble()));
        break;
      }

      result.add(FlSpot(i.toDouble(), a.toDouble()));
    }

    return result;
  }

  List<FlSpot> generateChartDataForLowest(List<BloodPressureRecordModel> data) {
    final arr = data.map((e) => e.dia).toList();
    final result = <FlSpot>[];

    for (var i = 0; i < arr.length; i++) {
      final a = arr[i];

      if (data.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, a.toDouble()));
        break;
      }

      result.add(FlSpot(i.toDouble(), a.toDouble()));
    }

    return result;
  }

  @override
  List<BloodPressureRecordModel> getDailyReport() {
    final today = DateTime.now();
    final dailyRecords = state.records.where((record) => record.recordDate.year == today.year && record.recordDate.month == today.month && record.recordDate.day == today.day).toList();
    return dailyRecords;
  }

  @override
  List<BloodPressureRecordModel> getMontlyReport() {
    final today = DateTime.now();
    final monthlyRecords = state.records.where((record) => record.recordDate.year == today.year && record.recordDate.month == today.month).toList();
    return monthlyRecords;
  }

  @override
  List<BloodPressureRecordModel> getPastReport(DateTime from, DateTime to) {
    final pastRecords = state.records.where((record) => record.recordDate.isAfter(from) && record.recordDate.isBefore(to)).toList();
    return pastRecords;
  }

  @override
  BloodPressureRecordModel? getPastReportSingle(DateTime date) {
    return state.records.firstWhereOrNull((a) => Common.isDateSame(a.recordDate, date));
  }

  @override
  double getScore({List<BloodPressureRecordModel>? records}) {
    records ??= state.records;

    if (records.isEmpty) return 0.0;

    final averageSys = records.map((r) => r.sys).reduce((a, b) => a + b) / records.length;
    final averageDia = records.map((r) => r.dia).reduce((a, b) => a + b) / records.length;

    if (averageSys < 120 && averageDia < 80) {
      return 10.0;
    } else if (averageSys < 130 && averageDia < 85) {
      return 8.0;
    } else if (averageSys < 140 && averageDia < 90) {
      return 6.0;
    } else if (averageSys < 160 && averageDia < 100) {
      return 4.0;
    } else {
      return 2.0;
    }
  }

  @override
  List<BloodPressureRecordModel> getWeeklyReport() {
    final today = DateTime.now();
    final weekAgo = today.subtract(const Duration(days: 7));
    final weeklyRecords = state.records.where((record) => record.recordDate.isAfter(weekAgo) && record.recordDate.isBefore(today)).toList();
    return weeklyRecords;
  }

  @override
  void record(BloodPressureRecordModel newRecord) {
    final updatedRecords = List<BloodPressureRecordModel>.from(state.records)..add(newRecord);
    emit(state.copyWith(records: updatedRecords));
  }
}

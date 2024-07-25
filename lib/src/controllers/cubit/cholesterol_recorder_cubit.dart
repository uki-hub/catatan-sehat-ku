import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/base/base_recorder_cubit.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/models/cholesterol_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:collection/collection.dart';

part 'cholesterol_recorder_state.dart';

class CholesterolRecorderCubit extends Cubit<CholesterolRecorderState> implements BaseRecorderCubit<CholesterolRecordModel> {
  CholesterolRecorderCubit() : super(CholesterolRecorderInitial());

  @override
  void clear() {
    emit(CholesterolRecorderState(records: []));
  }

  @override
  List<FlSpot> generateChartData(List<CholesterolRecordModel> data) {
    throw UnimplementedError();
  }

  List<FlSpot> generateChartDataForHIghest(List<CholesterolRecordModel> data) {
    final arr = data.map((e) => e.hdl).toList();
    final result = <FlSpot>[];

    for (var i = 0; i < arr.length; i++) {
      final a = arr[i];
      final y = a.toDouble();

      if (data.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, y));
        break;
      }

      result.add(FlSpot(i.toDouble(), y));
    }

    return result;
  }

  List<FlSpot> generateChartDataForLowest(List<CholesterolRecordModel> data) {
    final arr = data.map((e) => e.ldl).toList();
    final result = <FlSpot>[];

    for (var i = 0; i < arr.length; i++) {
      final a = arr[i];
      final y = a.toDouble();

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
  List<CholesterolRecordModel> getDailyReport() {
    final today = DateTime.now();
    return state.records.where((record) => record.recordDate.year == today.year && record.recordDate.month == today.month && record.recordDate.day == today.day).toList();
  }

  @override
  List<CholesterolRecordModel> getMontlyReport() {
    final now = DateTime.now();
    return state.records.where((record) => record.recordDate.year == now.year && record.recordDate.month == now.month).toList();
  }

  @override
  CholesterolRecordModel? getPastReportSingle(DateTime date) {
    return state.records.firstWhereOrNull((a) => Common.isDateSame(a.recordDate, date));
  }

  @override
  List<CholesterolRecordModel> getPastReport(DateTime from, DateTime to) {
    return state.records.where((record) => record.recordDate.isAfter(from) && record.recordDate.isBefore(to)).toList();
  }

  @override
  double getScore({List<CholesterolRecordModel>? records}) {
    records ??= state.records;

    if (records.isEmpty) return 0.0;

    final totalHDL = records.map((record) => record.hdl).reduce((a, b) => a + b);
    final totalLDL = records.map((record) => record.ldl).reduce((a, b) => a + b);
    final averageHDL = totalHDL / records.length;
    final averageLDL = totalLDL / records.length;

    final score = (averageHDL / 100.0) * 5.0 + (averageLDL / 150.0) * 5.0;
    return double.parse(score.toStringAsFixed(1));
  }

  @override
  List<CholesterolRecordModel> getWeeklyReport() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));
    return state.records.where((record) => record.recordDate.isAfter(startOfWeek) && record.recordDate.isBefore(now)).toList();
  }

  @override
  void record(CholesterolRecordModel newRecord) {
    final updatedRecords = List<CholesterolRecordModel>.from(state.records)..add(newRecord);
    emit(CholesterolRecorderState(records: updatedRecords));
  }
}

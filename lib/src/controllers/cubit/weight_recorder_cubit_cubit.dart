import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:catatan_sehat_ku/base/base_recorder_cubit.dart';
import 'package:catatan_sehat_ku/etc/common.dart';
import 'package:catatan_sehat_ku/src/models/weight_record_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:collection/collection.dart'; 

part 'weight_recorder_cubit_state.dart';

class WeightRecorderCubit extends Cubit<WeightRecorderState> implements BaseRecorderCubit<WeightRecordModel> {
  WeightRecorderCubit() : super(WeightRecorderInitial());

  @override
  void clear() {
    emit(WeightRecorderState(records: []));
  }

  @override
  List<FlSpot> generateChartData(List<WeightRecordModel> data) {
    final result = <FlSpot>[];

    for (var i = 0; i < data.length; i++) {
      var d = data[i];

      if (data.length == 1) {
        result.add(const FlSpot(0, 0));
        result.add(FlSpot(i.toDouble() + 1, d.weight.toDouble()));
        break;
      }

      result.add(FlSpot(i.toDouble(), d.weight.toDouble()));
    }

    return result;
  }

  @override
  List<WeightRecordModel> getDailyReport() {
    final today = DateTime.now();
    return state.records.where((record) => record.recordDate.year == today.year && record.recordDate.month == today.month && record.recordDate.day == today.day).toList();
  }

  @override
  List<WeightRecordModel> getMontlyReport() {
    final now = DateTime.now();
    return state.records.where((record) => record.recordDate.year == now.year && record.recordDate.month == now.month).toList();
  }

  @override
  List<WeightRecordModel> getPastReport(DateTime from, DateTime to) {
    return state.records.where((record) => record.recordDate.isAfter(from) && record.recordDate.isBefore(to)).toList();
  }

  @override
  WeightRecordModel? getPastReportSingle(DateTime date) {
    return state.records.firstWhereOrNull((a) => Common.isDateSame(a.recordDate, date));
  }

  @override
  double getScore({List<WeightRecordModel>? records}) {
    records ??= state.records;
    if (records.isEmpty) return 0.0;

    final totalWeight = records.map((record) => record.weight).reduce((a, b) => a + b);
    final averageWeight = totalWeight / records.length;

    const maxWeight = 150.0; 
    final rating = (averageWeight / maxWeight) * 10.0;

    return rating.clamp(0.0, 10.0);
  }

  @override
  List<WeightRecordModel> getWeeklyReport() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday));
    return state.records.where((record) => record.recordDate.isAfter(startOfWeek) && record.recordDate.isBefore(now)).toList();
  }

  @override
  void record(WeightRecordModel newRecord) {
    final updatedRecords = List<WeightRecordModel>.from(state.records)..add(newRecord);
    emit(WeightRecorderState(records: updatedRecords));
  }
}

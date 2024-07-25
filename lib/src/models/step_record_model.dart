import 'dart:convert';

import 'package:equatable/equatable.dart';

class StepRecordModel extends Equatable {
  final int stepsCount;
  final DateTime recordDate;

  const StepRecordModel({required this.stepsCount, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stepsCount': stepsCount,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory StepRecordModel.fromMap(Map<String, dynamic> map) {
    return StepRecordModel(
      stepsCount: map['stepsCount'] as int,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory StepRecordModel.fromJson(String source) => StepRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StepRecordModel copyWith({
    int? stepsCount,
    DateTime? recordDate,
  }) {
    return StepRecordModel(
      stepsCount: stepsCount ?? this.stepsCount,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [stepsCount, recordDate];
}

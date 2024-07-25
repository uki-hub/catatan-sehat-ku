import 'dart:convert';

import 'package:equatable/equatable.dart';

class MemoryTestRecordModel extends Equatable {
  final int score;
  final DateTime recordDate;

  const MemoryTestRecordModel({required this.score, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory MemoryTestRecordModel.fromMap(Map<String, dynamic> map) {
    return MemoryTestRecordModel(
      score: map['score'] as int,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MemoryTestRecordModel.fromJson(String source) => MemoryTestRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  MemoryTestRecordModel copyWith({
    int? score,
    DateTime? recordDate,
  }) {
    return MemoryTestRecordModel(
      score: score ?? this.score,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [score, recordDate];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class GameRecordModel extends Equatable {
  final int totalSeconds;
  final DateTime recordDate;

  const GameRecordModel({required this.totalSeconds, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalSeconds': totalSeconds,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory GameRecordModel.fromMap(Map<String, dynamic> map) {
    return GameRecordModel(
      totalSeconds: map['totalSeconds'] as int,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameRecordModel.fromJson(String source) => GameRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GameRecordModel copyWith({
    int? totalSeconds,
    DateTime? recordDate,
  }) {
    return GameRecordModel(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [totalSeconds, recordDate];
}

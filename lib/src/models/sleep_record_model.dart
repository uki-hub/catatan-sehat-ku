import 'dart:convert';
import 'package:equatable/equatable.dart';

class SleepRecordModel extends Equatable {
  final DateTime from;
  final DateTime to;
  final DateTime dateOfSleep;
  final DateTime recordDate;

  const SleepRecordModel({required this.from, required this.to, required this.dateOfSleep, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'dateOfSleep': dateOfSleep.millisecondsSinceEpoch,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory SleepRecordModel.fromMap(Map<String, dynamic> map) {
    return SleepRecordModel(
      from: DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      to: DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
      dateOfSleep: DateTime.fromMillisecondsSinceEpoch(map['dateOfSleep'] as int),
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SleepRecordModel.fromJson(String source) => SleepRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SleepRecordModel copyWith({
    DateTime? from,
    DateTime? to,
    DateTime? dateOfSleep,
    DateTime? recordDate,
  }) {
    return SleepRecordModel(
      from: from ?? this.from,
      to: to ?? this.to,
      dateOfSleep: dateOfSleep ?? this.dateOfSleep,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [from, to, dateOfSleep, recordDate];
}

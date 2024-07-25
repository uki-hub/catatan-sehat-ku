import 'dart:convert';
import 'package:equatable/equatable.dart';

class BloodPressureRecordModel extends Equatable {
  final int sys;
  final int dia;
  final int pulse;
  final DateTime recordDate;

  const BloodPressureRecordModel({required this.sys, required this.dia, required this.pulse, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sys': sys,
      'dia': dia,
      'pulse': pulse,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory BloodPressureRecordModel.fromMap(Map<String, dynamic> map) {
    return BloodPressureRecordModel(
      sys: map['sys'] as int,
      dia: map['dia'] as int,
      pulse: map['pulse'] as int,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodPressureRecordModel.fromJson(String source) => BloodPressureRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  BloodPressureRecordModel copyWith({
    int? sys,
    int? dia,
    int? pulse,
    DateTime? recordDate,
  }) {
    return BloodPressureRecordModel(
      sys: sys ?? this.sys,
      dia: dia ?? this.dia,
      pulse: pulse ?? this.pulse,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [sys, dia, pulse, recordDate];
}

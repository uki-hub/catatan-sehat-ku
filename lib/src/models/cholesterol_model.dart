import 'dart:convert';

import 'package:equatable/equatable.dart';

class CholesterolRecordModel extends Equatable {
  final double hdl;
  final double ldl;
  final DateTime recordDate;

  const CholesterolRecordModel({required this.hdl, required this.ldl, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hdl': hdl,
      'ldl': ldl,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory CholesterolRecordModel.fromMap(Map<String, dynamic> map) {
    return CholesterolRecordModel(
      hdl: map['hdl'] as double,
      ldl: map['ldl'] as double,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CholesterolRecordModel.fromJson(String source) => CholesterolRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CholesterolRecordModel copyWith({
    double? hdl,
    double? ldl,
    DateTime? recordDate,
  }) {
    return CholesterolRecordModel(
      hdl: hdl ?? this.hdl,
      ldl: ldl ?? this.ldl,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [hdl, ldl, recordDate];
}

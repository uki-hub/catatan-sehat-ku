// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeightRecordModel extends Equatable {
  final double weight;
  final DateTime recordDate;

  const WeightRecordModel({required this.weight, required this.recordDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'recordDate': recordDate.millisecondsSinceEpoch,
    };
  }

  factory WeightRecordModel.fromMap(Map<String, dynamic> map) {
    return WeightRecordModel(
      weight: map['weight'] as double,
      recordDate: DateTime.fromMillisecondsSinceEpoch(map['recordDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightRecordModel.fromJson(String source) => WeightRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WeightRecordModel copyWith({
    double? weight,
    DateTime? recordDate,
  }) {
    return WeightRecordModel(
      weight: weight ?? this.weight,
      recordDate: recordDate ?? this.recordDate,
    );
  }

  @override
  List<Object> get props => [weight, recordDate];
}

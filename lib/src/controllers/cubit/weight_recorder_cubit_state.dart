part of 'weight_recorder_cubit_cubit.dart';

class WeightRecorderState extends Equatable {
  final List<WeightRecordModel> records;

  const WeightRecorderState({required this.records});

  @override
  List<Object> get props => [records];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory WeightRecorderState.fromMap(Map<String, dynamic> map) {
    return WeightRecorderState(
      records: List<WeightRecordModel>.from(
        (map['records'] as List<int>).map<WeightRecordModel>(
          (x) => WeightRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightRecorderState.fromJson(String source) => WeightRecorderState.fromMap(json.decode(source) as Map<String, dynamic>);

  WeightRecorderState copyWith({
    List<WeightRecordModel>? records,
  }) {
    return WeightRecorderState(
      records: records ?? this.records,
    );
  }
}

class WeightRecorderInitial extends WeightRecorderState {
  WeightRecorderInitial() : super(records: []);
}

// class WeightRecorderInitial extends WeightRecorderState {
//   WeightRecorderInitial()
//       : super(records: [
//           WeightRecordModel(
//             weight: 70.5,
//             recordDate: DateTime(2024, 6, 1),
//           ),
//           WeightRecordModel(
//             weight: 71.2,
//             recordDate: DateTime(2024, 6, 2),
//           ),
//           WeightRecordModel(
//             weight: 69.8,
//             recordDate: DateTime(2024, 6, 3),
//           ),
//           WeightRecordModel(
//             weight: 72.1,
//             recordDate: DateTime(2024, 6, 4),
//           ),
//           WeightRecordModel(
//             weight: 70.9,
//             recordDate: DateTime(2024, 6, 5),
//           ),
//           WeightRecordModel(
//             weight: 73.0,
//             recordDate: DateTime(2024, 6, 6),
//           ),
//           WeightRecordModel(
//             weight: 69.5,
//             recordDate: DateTime(2024, 6, 7),
//           ),
//           WeightRecordModel(
//             weight: 74.2,
//             recordDate: DateTime(2024, 6, 8),
//           ),
//           WeightRecordModel(
//             weight: 71.8,
//             recordDate: DateTime(2024, 6, 9),
//           ),
//           WeightRecordModel(
//             weight: 75.0,
//             recordDate: DateTime(2024, 6, 10),
//           ),
//         ]);
// }

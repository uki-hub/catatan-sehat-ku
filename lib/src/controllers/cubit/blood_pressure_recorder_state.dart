part of 'blood_pressure_recorder_cubit.dart';

class BloodPressureRecorderState extends Equatable {
  final List<BloodPressureRecordModel> records;

  const BloodPressureRecorderState({required this.records});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory BloodPressureRecorderState.fromMap(Map<String, dynamic> map) {
    return BloodPressureRecorderState(
      records: List<BloodPressureRecordModel>.from(
        (map['records'] as List<int>).map<BloodPressureRecordModel>(
          (x) => BloodPressureRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodPressureRecorderState.fromJson(String source) => BloodPressureRecorderState.fromMap(json.decode(source) as Map<String, dynamic>);

  BloodPressureRecorderState copyWith({
    List<BloodPressureRecordModel>? records,
  }) {
    return BloodPressureRecorderState(
      records: records ?? this.records,
    );
  }

  @override
  List<Object> get props => [records];
}

class BloodPressureRecorderInitial extends BloodPressureRecorderState {
  BloodPressureRecorderInitial() : super(records: []);
}

// class BloodPressureRecorderInitial extends BloodPressureRecorderState {
//   BloodPressureRecorderInitial()
//       : super(records: [
//           BloodPressureRecordModel(
//             sys: 120,
//             dia: 80,
//             pulse: 70,
//             recordDate: DateTime(2024, 6, 1),
//           ),
//           BloodPressureRecordModel(
//             sys: 130,
//             dia: 85,
//             pulse: 72,
//             recordDate: DateTime(2024, 6, 2),
//           ),
//           BloodPressureRecordModel(
//             sys: 115,
//             dia: 75,
//             pulse: 68,
//             recordDate: DateTime(2024, 6, 3),
//           ),
//           BloodPressureRecordModel(
//             sys: 125,
//             dia: 78,
//             pulse: 71,
//             recordDate: DateTime(2024, 6, 4),
//           ),
//           BloodPressureRecordModel(
//             sys: 122,
//             dia: 79,
//             pulse: 69,
//             recordDate: DateTime(2024, 6, 5),
//           ),
//           BloodPressureRecordModel(
//             sys: 128,
//             dia: 82,
//             pulse: 73,
//             recordDate: DateTime(2024, 6, 6),
//           ),
//           BloodPressureRecordModel(
//             sys: 118,
//             dia: 77,
//             pulse: 67,
//             recordDate: DateTime(2024, 6, 7),
//           ),
//           BloodPressureRecordModel(
//             sys: 132,
//             dia: 84,
//             pulse: 74,
//             recordDate: DateTime(2024, 6, 8),
//           ),
//           BloodPressureRecordModel(
//             sys: 123,
//             dia: 76,
//             pulse: 70,
//             recordDate: DateTime(2024, 6, 9),
//           ),
//           BloodPressureRecordModel(
//             sys: 127,
//             dia: 81,
//             pulse: 72,
//             recordDate: DateTime(2024, 6, 10),
//           ),
//         ]);
// }

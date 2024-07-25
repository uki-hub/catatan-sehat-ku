part of 'cholesterol_recorder_cubit.dart';

class CholesterolRecorderState extends Equatable {
  final List<CholesterolRecordModel> records;

  const CholesterolRecorderState({required this.records});

  @override
  List<Object> get props => [records];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory CholesterolRecorderState.fromMap(Map<String, dynamic> map) {
    return CholesterolRecorderState(
      records: List<CholesterolRecordModel>.from(
        (map['records'] as List<int>).map<CholesterolRecordModel>(
          (x) => CholesterolRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CholesterolRecorderState.fromJson(String source) => CholesterolRecorderState.fromMap(json.decode(source) as Map<String, dynamic>);

  CholesterolRecorderState copyWith({
    List<CholesterolRecordModel>? records,
  }) {
    return CholesterolRecorderState(
      records: records ?? this.records,
    );
  }
}

class CholesterolRecorderInitial extends CholesterolRecorderState {
  CholesterolRecorderInitial() : super(records: []);
}

// class CholesterolRecorderInitial extends CholesterolRecorderState {
//   CholesterolRecorderInitial()
//       : super(
//           records: [
//             CholesterolRecordModel(
//               hdl: 60.5,
//               ldl: 120.3,
//               recordDate: DateTime(2024, 6, 1),
//             ),
//             CholesterolRecordModel(
//               hdl: 65.2,
//               ldl: 115.8,
//               recordDate: DateTime(2024, 6, 2),
//             ),
//             CholesterolRecordModel(
//               hdl: 58.7,
//               ldl: 122.1,
//               recordDate: DateTime(2024, 6, 3),
//             ),
//             CholesterolRecordModel(
//               hdl: 63.0,
//               ldl: 118.6,
//               recordDate: DateTime(2024, 6, 4),
//             ),
//             CholesterolRecordModel(
//               hdl: 61.8,
//               ldl: 121.0,
//               recordDate: DateTime(2024, 6, 5),
//             ),
//             CholesterolRecordModel(
//               hdl: 64.9,
//               ldl: 116.5,
//               recordDate: DateTime(2024, 6, 6),
//             ),
//             CholesterolRecordModel(
//               hdl: 58.5,
//               ldl: 123.2,
//               recordDate: DateTime(2024, 6, 7),
//             ),
//             CholesterolRecordModel(
//               hdl: 67.2,
//               ldl: 114.7,
//               recordDate: DateTime(2024, 6, 8),
//             ),
//             CholesterolRecordModel(
//               hdl: 62.8,
//               ldl: 119.4,
//               recordDate: DateTime(2024, 6, 9),
//             ),
//             CholesterolRecordModel(
//               hdl: 68.0,
//               ldl: 113.9,
//               recordDate: DateTime(2024, 6, 10),
//             ),
//           ],
//         );
// }

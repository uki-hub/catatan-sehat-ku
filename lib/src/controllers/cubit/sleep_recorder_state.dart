part of 'sleep_recorder_cubit.dart';

class SleepRecorderState extends Equatable {
  final List<SleepRecordModel> records;

  const SleepRecorderState({required this.records});

  @override
  List<Object> get props => [records];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory SleepRecorderState.fromMap(Map<String, dynamic> map) {
    return SleepRecorderState(
      records: List<SleepRecordModel>.from(
        (map['records'] as List<int>).map<SleepRecordModel>(
          (x) => SleepRecordModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SleepRecorderState.fromJson(String source) => SleepRecorderState.fromMap(json.decode(source) as Map<String, dynamic>);

  SleepRecorderState copyWith({
    List<SleepRecordModel>? records,
  }) {
    return SleepRecorderState(
      records: records ?? this.records,
    );
  }
}

class SleepRecorderInitial extends SleepRecorderState {
  SleepRecorderInitial() : super(records: []);
}

// class SleepRecorderInitial extends SleepRecorderState {
//   SleepRecorderInitial()
//       : super(records: [
//           SleepRecordModel(
//             from: DateTime(2024, 6, 1, 22, 0), // 10:00 PM
//             to: DateTime(2024, 6, 2, 6, 30), // 6:30 AM
//             dateOfSleep: DateTime(2024, 6, 1),
//             recordDate: DateTime(2024, 6, 2),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 2, 21, 30), // 9:30 PM
//             to: DateTime(2024, 6, 3, 7, 0), // 7:00 AM
//             dateOfSleep: DateTime(2024, 6, 2),
//             recordDate: DateTime(2024, 6, 3),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 3, 23, 0), // 11:00 PM
//             to: DateTime(2024, 6, 4, 6, 45), // 6:45 AM
//             dateOfSleep: DateTime(2024, 6, 3),
//             recordDate: DateTime(2024, 6, 4),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 4, 22, 15), // 10:15 PM
//             to: DateTime(2024, 6, 5, 5, 45), // 5:45 AM
//             dateOfSleep: DateTime(2024, 6, 4),
//             recordDate: DateTime(2024, 6, 5),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 5, 23, 30), // 11:30 PM
//             to: DateTime(2024, 6, 6, 6, 15), // 6:15 AM
//             dateOfSleep: DateTime(2024, 6, 5),
//             recordDate: DateTime(2024, 6, 6),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 6, 22, 45), // 10:45 PM
//             to: DateTime(2024, 6, 7, 7, 30), // 7:30 AM
//             dateOfSleep: DateTime(2024, 6, 6),
//             recordDate: DateTime(2024, 6, 7),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 7, 21, 0), // 9:00 PM
//             to: DateTime(2024, 6, 8, 6, 0), // 6:00 AM
//             dateOfSleep: DateTime(2024, 6, 7),
//             recordDate: DateTime(2024, 6, 8),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 8, 22, 30), // 10:30 PM
//             to: DateTime(2024, 6, 9, 6, 45), // 6:45 AM
//             dateOfSleep: DateTime(2024, 6, 8),
//             recordDate: DateTime(2024, 6, 9),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 9, 23, 15), // 11:15 PM
//             to: DateTime(2024, 6, 10, 7, 15), // 7:15 AM
//             dateOfSleep: DateTime(2024, 6, 9),
//             recordDate: DateTime(2024, 6, 10),
//           ),
//           SleepRecordModel(
//             from: DateTime(2024, 6, 10, 22, 0), // 10:00 PM
//             to: DateTime(2024, 6, 11, 6, 30), // 6:30 AM
//             dateOfSleep: DateTime(2024, 6, 10),
//             recordDate: DateTime(2024, 6, 11),
//           ),
//         ]);
// }

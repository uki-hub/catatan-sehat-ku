// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_cubit.dart';

class GameState extends Equatable {
  final List<GameRecordModel> records;

  const GameState({required this.records});

  @override
  List<Object> get props => [records];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'records': records.map((x) => x.toMap()).toList(),
    };
  }

  factory GameState.fromMap(Map<String, dynamic> map) {
    return GameState(
      records: List<GameRecordModel>.from((map['records'] as List<int>).map<GameRecordModel>((x) => GameRecordModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameState.fromJson(String source) => GameState.fromMap(json.decode(source) as Map<String, dynamic>);

  GameState copyWith({
    List<GameRecordModel>? records,
  }) {
    return GameState(
      records: records ?? this.records,
    );
  }
}

class GameInitial extends GameState {
  GameInitial() : super(records: []);
}

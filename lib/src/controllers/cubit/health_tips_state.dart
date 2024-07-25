part of 'health_tips_cubit.dart';

class HealthTipsState extends Equatable {
  final int currentIndex;
  final List<String> healthTips;

  const HealthTipsState({required this.currentIndex, required this.healthTips});

  HealthTipsState copyWith({
    int? currentIndex,
  }) {
    return HealthTipsState(
      currentIndex: currentIndex ?? this.currentIndex,
      healthTips: healthTips,
    );
  }

  @override
  List<Object> get props => [currentIndex, healthTips];
}

class HealthTipsInitial extends HealthTipsState {
  HealthTipsInitial()
      : super(currentIndex: Random().nextInt(20), healthTips: [
          "Drink plenty of water.",
          "Get enough sleep.",
          "Exercise regularly.",
          "Eat more fruits and vegetables.",
          "Take breaks to avoid burnout.",
          "Practice good hygiene.",
          "Avoid smoking.",
          "Limit alcohol consumption.",
          "Manage stress effectively.",
          "Maintain a healthy weight.",
          "Wash your hands frequently.",
          "Get regular medical check-ups.",
          "Stay active throughout the day.",
          "Practice safe sun exposure.",
          "Maintain a balanced diet.",
          "Take the stairs instead of the elevator.",
          "Limit processed foods.",
          "Practice mindfulness and meditation.",
          "Floss and brush your teeth daily.",
          "Get vaccinated."
        ]);
}

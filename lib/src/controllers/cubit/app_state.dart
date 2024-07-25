part of 'app_cubit.dart';

class AppState extends Equatable {
  final String theme;
  final ThemeData themeData;

  const AppState({required this.theme, required this.themeData});

  @override
  List<Object> get props => [theme];

  AppState copyWith({
    String? theme,
    ThemeData? themeData,
  }) {
    return AppState(
      theme: theme ?? this.theme,
      themeData: themeData ?? this.themeData,
    );
  }
}

class AppInitial extends AppState {
  const AppInitial({required super.theme, required super.themeData});
}

part of 'settings_cubit.dart';

@JsonSerializable()
class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.mainColor = 0xFF1578EA,
    this.questions = const [],
    this.levels = const [],
  });

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);

  final ThemeMode themeMode;
  final int mainColor;
  final List<Question> questions;
  final List<String> levels;

  @override
  List<Object> get props => [themeMode, questions, levels, mainColor];

  Map<String, dynamic> toJson() => _$SettingsStateToJson(this);

  SettingsState copyWith({
    ThemeMode? themeMode,
    List<Question>? questions,
    List<String>? levels,
    int? mainColor,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      questions: questions ?? this.questions,
      levels: levels ?? this.levels,
      mainColor: mainColor ?? this.mainColor,
    );
  }
}

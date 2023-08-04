part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.dark,
  });

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  SettingsState copyWith({ThemeMode? themeMode}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

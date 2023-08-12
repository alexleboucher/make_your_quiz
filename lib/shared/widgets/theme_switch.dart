import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((SettingsCubit cubit) => cubit.state.themeMode);

    return DayNightSwitch(
      value: themeMode == ThemeMode.dark,
      onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
    );
  }
}

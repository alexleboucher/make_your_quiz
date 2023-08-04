import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.showThemeSwitch = true,
    super.key,
  });

  final Widget? body;
  final bool showThemeSwitch;

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((SettingsCubit cubit) => cubit.state.themeMode);

    return Scaffold(
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: showThemeSwitch
          ? SizedBox(
              height: 32,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: themeMode == ThemeMode.light,
                  onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
                ),
              ),
            )
          : null,
    );
  }
}

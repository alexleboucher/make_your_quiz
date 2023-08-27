import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';

import 'package:make_your_quiz/app/util/app_theme.dart';
import 'package:make_your_quiz/home/view/home_page.dart';
import 'package:make_your_quiz/play/view/play_page.dart';
import 'package:make_your_quiz/score/view/score_page.dart';
import 'package:make_your_quiz/settings/view/settings_page.dart';

class App extends StatelessWidget {
  App({super.key});

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomePage(),
        '/settings': (context, state, data) => const SettingsPage(),
        '/play': (context, state, data) => const PlayPage(),
        '/score': (context, state, data) => const ScorePage(),
      },
    ).call,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            theme: AppTheme.getTheme(themeMode: settingsState.themeMode),
            routerDelegate: routerDelegate,
            routeInformationParser: BeamerParser(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

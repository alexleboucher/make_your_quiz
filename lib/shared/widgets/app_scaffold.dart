import 'package:flutter/material.dart';
import 'package:make_your_quiz/shared/widgets/theme_switch.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.showThemeSwitch = false,
    super.key,
  });

  final Widget? body;
  final bool showThemeSwitch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: showThemeSwitch
          ? const SizedBox(
              height: 12,
              child: FittedBox(fit: BoxFit.fill, child: ThemeSwitch()),
            )
          : null,
    );
  }
}

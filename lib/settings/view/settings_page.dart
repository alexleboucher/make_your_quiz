import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          Positioned(
            right: 15,
            top: 15,
            child: IconButton(
              onPressed: () => context.beamToNamed('/'),
              icon: const Icon(Icons.close),
              iconSize: 30,
            ),
          ),
          const Center(
            child: AppText('SETTINGS'),
          ),
        ],
      ),
    );
  }
}

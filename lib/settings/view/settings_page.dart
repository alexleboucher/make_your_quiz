import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/settings/view/levels/levels_section.dart';
import 'package:make_your_quiz/settings/view/questions/questions_section.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showThemeSwitch: false,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'Paramètres',
                    typo: Typo.displaySmall,
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => context.beamToNamed('/'),
                    icon: const Icon(Icons.close),
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const QuestionsSection(),
              const SizedBox(height: 10),
              const LevelsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

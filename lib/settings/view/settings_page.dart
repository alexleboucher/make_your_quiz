import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/settings/view/levels/levels_section.dart';
import 'package:make_your_quiz/settings/view/questions/questions_section.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor =
        context.select((SettingsCubit cubit) => cubit.state.mainColor);

    return AppScaffold(
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
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close),
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const AppText('Couleur principale'),
                  const SizedBox(width: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => {
                        showDialog<dynamic>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Sélectionner une couleur'),
                              content: BlockPicker(
                                pickerColor: Color(mainColor),
                                onColorChanged: (Color color) => context
                                    .read<SettingsCubit>()
                                    .editMainColor(color),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Valider'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(mainColor),
                        ),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class ApplicationSection extends StatelessWidget {
  const ApplicationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor =
        context.select((SettingsCubit cubit) => cubit.state.mainColor);

    return ExpansionTile(
      shape: Border.all(color: Colors.transparent),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: AppText(
        'Application',
        typo: Typo.headlineSmall,
        style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.w400,
        ),
      ),
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              const AppText('Couleur principale'),
              const SizedBox(width: 20),
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
        ),
      ],
    );
  }
}

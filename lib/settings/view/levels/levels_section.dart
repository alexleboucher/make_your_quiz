import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/settings/view/levels/level_dialog.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';
import 'package:make_your_quiz/shared/widgets/custom_expansion_tile.dart';

class LevelsSection extends StatelessWidget {
  const LevelsSection({super.key});

  static const noLevelsWarning =
      'La liste de niveaux est vide. Aucun niveau ne sera affiché sur la page de score.';

  @override
  Widget build(BuildContext context) {
    final levels = context.select((SettingsCubit cubit) => cubit.state.levels);
    final questions =
        context.select((SettingsCubit cubit) => cubit.state.questions);

    return CustomExpansionTile(
      shape: Border.all(color: Colors.transparent),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            'Niveaux (${levels.length})',
            typo: Typo.headlineSmall,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w400,
              color: questions.length != levels.length ? Colors.amber : null,
            ),
          ),
          if (levels.isNotEmpty && questions.length != levels.length) ...[
            const SizedBox(width: 5),
            const Tooltip(
              message:
                  "Le nombre de niveaux et de questions n'est pas le même.",
              child: Icon(
                Icons.warning_rounded,
                color: Colors.amber,
                size: 25,
              ),
            ),
          ],
          if (levels.isEmpty && questions.isNotEmpty) ...[
            const SizedBox(width: 5),
            const Tooltip(
              message: noLevelsWarning,
              child: Icon(
                Icons.warning_rounded,
                color: Colors.amber,
                size: 25,
              ),
            ),
          ],
        ],
      ),
      trailingBeforeExpand: [
        IconButton(
          onPressed: () => showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) => LevelDialog(
              onSubmit: context.read<SettingsCubit>().addLevel,
            ),
          ),
          icon: const Icon(Icons.add),
        ),
      ],
      children: levels.isNotEmpty
          ? [
              const SizedBox(height: 3),
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ReorderableListView(
                  buildDefaultDragHandles: false,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < levels.length; i++)
                      Card(
                        key: Key('$i'),
                        child: ListTile(
                          title: Text(levels[i]),
                          leading: ReorderableDragStartListener(
                            index: i,
                            child: const Icon(Icons.drag_handle),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => showDialog<dynamic>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      LevelDialog(
                                    level: levels[i],
                                    onSubmit: (level) => context
                                        .read<SettingsCubit>()
                                        .editLevel(i, level),
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => context
                                    .read<SettingsCubit>()
                                    .deleteLevel(i),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) => context
                      .read<SettingsCubit>()
                      .moveLevel(oldIndex, newIndex),
                ),
              ),
            ]
          : [
              const SizedBox(height: 5),
              const AppText(noLevelsWarning),
              const SizedBox(height: 5),
            ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/settings/view/questions/question_dialog.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';
import 'package:make_your_quiz/shared/widgets/custom_expansion_tile.dart';

class QuestionsSection extends StatelessWidget {
  const QuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final questions =
        context.select((SettingsCubit cubit) => cubit.state.questions);

    return CustomExpansionTile(
      shape: Border.all(color: Colors.transparent),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            'Questions (${questions.length})',
            typo: Typo.headlineSmall,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w400,
              color: questions.isEmpty
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
          ),
          if (questions.isEmpty) ...[
            const SizedBox(width: 5),
            Tooltip(
              message: 'La liste de question est vide',
              child: Icon(
                Icons.error_rounded,
                color: Theme.of(context).colorScheme.error,
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
            builder: (BuildContext context) => QuestionDialog(
              onSubmit: context.read<SettingsCubit>().addQuestion,
            ),
          ),
          icon: const Icon(Icons.add),
        ),
      ],
      children: questions.isNotEmpty
          ? [
              const SizedBox(height: 3),
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ReorderableListView(
                  buildDefaultDragHandles: false,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < questions.length; i++)
                      Card(
                        key: Key('$i'),
                        child: ListTile(
                          title: Text(questions[i].title),
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
                                      QuestionDialog(
                                    question: questions[i],
                                    onSubmit: (question) => context
                                        .read<SettingsCubit>()
                                        .editQuestion(i, question),
                                  ),
                                ),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => context
                                    .read<SettingsCubit>()
                                    .deleteQuestion(i),
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
                      .moveQuestion(oldIndex, newIndex),
                ),
              ),
            ]
          : [
              const SizedBox(height: 5),
              const AppText('La liste de questions est vide'),
              const SizedBox(height: 5),
            ],
    );
  }
}

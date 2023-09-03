import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/play/view/play_questions_area.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close),
                iconSize: 30,
              ),
            ),
          ),
          Expanded(
            child: PlayQuestionsArea(
              questions: context.read<SettingsCubit>().state.questions,
            ),
          ),
        ],
      ),
    );
  }
}

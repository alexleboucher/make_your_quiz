import 'package:flutter/material.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({required this.playQuestions, super.key});

  final List<PlayQuestion> playQuestions;

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Placeholder(),
    );
  }
}

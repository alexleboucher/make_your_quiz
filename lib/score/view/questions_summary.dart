import 'package:flutter/material.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({
    required this.playQuestions,
    super.key,
  });

  final List<PlayQuestion> playQuestions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: playQuestions
            .map((playQuestion) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Question : ${playQuestion.question.title}'),
                    AppText('Votre réponse : ${playQuestion.userAnswer}'),
                    AppText('Réponse : ${playQuestion.question.goodAnswer}'),
                    const SizedBox(height: 10),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

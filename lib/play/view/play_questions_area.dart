import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/model/question.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class PlayQuestionsArea extends StatefulWidget {
  const PlayQuestionsArea({
    required this.questions,
    super.key,
  });

  final List<Question> questions;

  @override
  State<PlayQuestionsArea> createState() => _PlayQuestionsAreaState();
}

class _PlayQuestionsAreaState extends State<PlayQuestionsArea> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentIndex];
    final shuffledAnswers = [
      currentQuestion.goodAnswer,
      ...currentQuestion.otherAnswers
    ]..shuffle();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            currentQuestion.title,
            typo: Typo.displaySmall,
            style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 30),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final answer in shuffledAnswers) ...[
                  ElevatedButton(
                    onPressed: () => print(answer),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(12),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        const Size(200, 50),
                      ),
                    ),
                    child: Text(answer),
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/model/question.dart';
import 'package:make_your_quiz/settings/view/question_form.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class QuestionDialog extends StatelessWidget {
  const QuestionDialog({this.question, super.key});

  final Question? question;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Créer une question',
                  typo: Typo.headlineSmall,
                  style: GoogleFonts.ubuntu(),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            QuestionForm(
              question: question,
            ),
          ],
        ),
      ),
    );
  }
}

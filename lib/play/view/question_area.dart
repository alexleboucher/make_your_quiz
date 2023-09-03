import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/play/view/play_questions_area.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class QuestionArea extends StatefulWidget {
  const QuestionArea({
    required this.question,
    required this.onAnswerClick,
    required this.onNextQuestion,
    super.key,
  });

  final QuestionWithShuffledAnswers question;
  final void Function(String) onAnswerClick;
  final void Function() onNextQuestion;

  @override
  State<QuestionArea> createState() => QuestionAreaState();
}

class QuestionAreaState extends State<QuestionArea> {
  String? selectedAnswer;
  bool showAnswer = false;

  void handleAnswerClick(String answer) {
    if (!showAnswer) {
      setState(() {
        selectedAnswer = answer;
        showAnswer = true;
      });
      widget.onAnswerClick(answer);

      Timer(const Duration(seconds: 3), () => widget.onNextQuestion());
    }
  }

  @override
  void didUpdateWidget(covariant QuestionArea oldWidget) {
    if (oldWidget.question.question != widget.question.question) {
      setState(() {
        selectedAnswer = null;
        showAnswer = false;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            widget.question.question.title,
            typo: Typo.displaySmall,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final answer in widget.question.shuffledAnswers) ...[
                  _AnswerButton(
                    text: answer,
                    isGoodAnswer: answer == widget.question.question.goodAnswer,
                    isSelected: answer == selectedAnswer,
                    showAnswer: showAnswer,
                    onClick: () => handleAnswerClick(answer),
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

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.text,
    required this.onClick,
    required this.isSelected,
    required this.isGoodAnswer,
    required this.showAnswer,
    super.key,
  });

  final void Function() onClick;
  final String text;
  final bool isSelected;
  final bool isGoodAnswer;
  final bool showAnswer;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? foregroundColor;

    if (showAnswer) {
      if (isGoodAnswer) {
        backgroundColor = Colors.green.shade900;
        foregroundColor = Colors.white;
      } else if (isSelected && !isGoodAnswer) {
        backgroundColor = Colors.red.shade900;
        foregroundColor = Colors.white;
      }
    }

    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(12),
        ),
        minimumSize: MaterialStateProperty.all(
          const Size(200, 50),
        ),
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all(backgroundColor)
            : null,
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all(foregroundColor)
            : null,
      ),
      child: Text(text),
    );
  }
}

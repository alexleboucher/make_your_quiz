import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/model/question.dart';
import 'package:make_your_quiz/play/view/question_area.dart';

class QuestionWithShuffledAnswers {
  QuestionWithShuffledAnswers({required this.question})
      : shuffledAnswers = question.getShuffledAnswers();

  final Question question;
  final List<String> shuffledAnswers;
}

class PlayQuestionsArea extends StatefulWidget {
  PlayQuestionsArea({
    required List<Question> questions,
    super.key,
  }) : questions = questions
            .map((e) => QuestionWithShuffledAnswers(question: e))
            .toList();

  final List<QuestionWithShuffledAnswers> questions;

  @override
  State<PlayQuestionsArea> createState() => _PlayQuestionsAreaState();
}

class _PlayQuestionsAreaState extends State<PlayQuestionsArea> {
  int currentIndex = 0;
  int aa = 0;
  List<PlayQuestion> playQuestions = [];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentIndex];

    void handleAnswerClick(String answer) {
      final playQuestion = PlayQuestion(
        question: currentQuestion.question,
        userAnswer: answer,
      );
      if (playQuestions.elementAtOrNull(currentIndex) == null) {
        setState(() {
          playQuestions.add(playQuestion);
        });
      } else {
        setState(() {
          playQuestions[currentIndex] = playQuestion;
        });
      }
    }

    void handleNextQuestion() {
      if (widget.questions.length > currentIndex + 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        context.beamToNamed(
          '/score',
          data: playQuestions,
        );
      }
    }

    return Column(
      children: [
        Expanded(
          child: QuestionArea(
            question: currentQuestion,
            onAnswerClick: handleAnswerClick,
            onNextQuestion: handleNextQuestion,
          ),
        ),
        TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: currentIndex.toDouble(),
            end: playQuestions.length.toDouble() / widget.questions.length,
          ),
          builder: (context, value, _) => LinearProgressIndicator(value: value),
        ),
      ],
    );
  }
}

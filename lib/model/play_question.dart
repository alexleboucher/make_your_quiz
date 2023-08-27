import 'package:equatable/equatable.dart';
import 'package:make_your_quiz/model/question.dart';

class PlayQuestion extends Equatable {
  const PlayQuestion({
    required this.question,
    required this.userAnswer,
  });

  final Question question;
  final String userAnswer;

  bool hasUserGoodAnswer() {
    return userAnswer == question.goodAnswer;
  }

  @override
  List<Object?> get props => [question, userAnswer];
}

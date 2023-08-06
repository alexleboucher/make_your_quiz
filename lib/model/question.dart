class Question {
  const Question({
    required this.title,
    required this.goodAnswer,
    required this.otherAnswers,
  });

  final String title;
  final String goodAnswer;
  final List<String> otherAnswers;
}

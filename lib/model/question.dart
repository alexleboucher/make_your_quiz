import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  const Question({
    required this.title,
    required this.goodAnswer,
    required this.otherAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object> get props => [title, goodAnswer, otherAnswers];

  final String title;
  final String goodAnswer;
  final List<String> otherAnswers;
}

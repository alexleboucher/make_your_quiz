// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      title: json['title'] as String,
      goodAnswer: json['goodAnswer'] as String,
      otherAnswers: (json['otherAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'title': instance.title,
      'goodAnswer': instance.goodAnswer,
      'otherAnswers': instance.otherAnswers,
    };

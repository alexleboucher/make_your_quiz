import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:make_your_quiz/model/question.dart';

part 'settings_state.dart';
part 'settings_cubit.g.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
  }

  void addQuestion(Question question) {
    final newQuestions = [...state.questions, question];
    emit(state.copyWith(questions: newQuestions));
  }

  void deleteQuestion(int index) {
    final newQuestions = [...state.questions]..removeAt(index);
    emit(state.copyWith(questions: newQuestions));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}

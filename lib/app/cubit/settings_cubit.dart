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

  void editMainColor(Color color) {
    emit(state.copyWith(mainColor: color.value));
  }

  void addQuestion(Question question) {
    final newQuestions = [...state.questions, question];
    emit(state.copyWith(questions: newQuestions));
  }

  void deleteQuestion(int index) {
    final newQuestions = [...state.questions]..removeAt(index);
    emit(state.copyWith(questions: newQuestions));
  }

  void editQuestion(int index, Question question) {
    final newQuestions = [...state.questions];
    newQuestions[index] = question;
    emit(state.copyWith(questions: newQuestions));
  }

  void moveQuestion(int oldIndex, int newIndex) {
    var newIdx = newIndex;
    final newQuestions = [...state.questions];
    if (oldIndex < newIndex) {
      newIdx -= 1;
    }
    final item = newQuestions.removeAt(oldIndex);
    newQuestions.insert(newIdx, item);
    emit(state.copyWith(questions: newQuestions));
  }

  void addLevel(String level) {
    final newLevels = [...state.levels, level];
    emit(state.copyWith(levels: newLevels));
  }

  void deleteLevel(int index) {
    final newLevels = [...state.levels]..removeAt(index);
    emit(state.copyWith(levels: newLevels));
  }

  void editLevel(int index, String level) {
    final newLevels = [...state.levels];
    newLevels[index] = level;
    emit(state.copyWith(levels: newLevels));
  }

  void moveLevel(int oldIndex, int newIndex) {
    var newIdx = newIndex;
    final newLevels = [...state.levels];
    if (oldIndex < newIndex) {
      newIdx -= 1;
    }
    final item = newLevels.removeAt(oldIndex);
    newLevels.insert(newIdx, item);
    emit(state.copyWith(levels: newLevels));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}

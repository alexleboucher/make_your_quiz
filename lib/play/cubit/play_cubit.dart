import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/model/play_question.dart';

part 'play_state.dart';

class PlayCubit extends Cubit<PlayState> {
  PlayCubit() : super(const PlayState());
}

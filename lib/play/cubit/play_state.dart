part of 'play_cubit.dart';

class PlayState extends Equatable {
  const PlayState({
    this.playQuestions = const [],
  });

  final List<PlayQuestion> playQuestions;

  @override
  List<Object?> get props => [playQuestions];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';
import 'package:make_your_quiz/shared/widgets/segmented_linear_progress_indicator.dart';

class ScorePage extends StatefulWidget {
  ScorePage({required this.playQuestions, super.key})
      : score = playQuestions
            .where((element) => element.hasUserGoodAnswer())
            .length;

  final List<PlayQuestion> playQuestions;
  final int score;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  bool isProgressBarAnimationEnded = false;

  @override
  void initState() {
    isProgressBarAnimationEnded = widget.score == 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final levels = context.select((SettingsCubit cubit) => cubit.state.levels);
    final screenWidth = MediaQuery.of(context).size.width;
    final numberOfQuestions = widget.playQuestions.length;
    final areLevelsValid = levels.length == numberOfQuestions + 1;

    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close),
                iconSize: 30,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SegmentedLinearProgressBar(
                    value:
                        widget.score.toDouble() / numberOfQuestions.toDouble(),
                    sectionsCount: numberOfQuestions,
                    width: 500,
                    height: 17,
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
                    segmentDisabledColor: Colors.grey,
                    progressDuration: const Duration(milliseconds: 1500),
                    color: Colors.green.shade800,
                    completedColor: Colors.amber.shade600,
                    borderRadius: BorderRadius.circular(10),
                    onEnd: () => setState(() {
                      isProgressBarAnimationEnded = true;
                    }),
                    topHint: AnimatedOpacity(
                      opacity: isProgressBarAnimationEnded ? 1 : 0,
                      duration: const Duration(seconds: 2),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 3),
                          child: AppText(
                            '${widget.score} bonne${widget.score > 1 ? 's' : ''} réponse${widget.score > 1 ? 's' : ''} sur $numberOfQuestions question${numberOfQuestions > 1 ? 's' : ''}',
                            typo: Typo.labelSmall,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (areLevelsValid) ...[
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                      opacity: isProgressBarAnimationEnded ? 1 : 0,
                      duration: const Duration(seconds: 2),
                      child: AppText(
                        levels[widget.score],
                        typo: Typo.titleMedium,
                      ),
                    )
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

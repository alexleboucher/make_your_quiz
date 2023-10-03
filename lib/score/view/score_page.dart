import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  static const hintAndLevelDuration = Duration(milliseconds: 1200);

  bool isProgressBarAnimationEnded = false;
  bool isHintAndLevelAnimationEnded = false;
  Timer? _timer;

  @override
  void initState() {
    if (widget.score == 0) {
      Timer.run(handleProgressBarAnimationEnded);
    }
    super.initState();
  }

  void handleProgressBarAnimationEnded() {
    setState(() {
      isProgressBarAnimationEnded = true;
    });
    _timer = Timer(
      hintAndLevelDuration,
      () => setState(() {
        isHintAndLevelAnimationEnded = true;
      }),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          Container(
            margin: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Score',
                  typo: Typo.displaySmall,
                  style: GoogleFonts.ubuntu(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedAlign(
              alignment: isHintAndLevelAnimationEnded
                  ? Alignment.topCenter
                  : Alignment.center,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 750),
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
                    progressDuration:
                        Duration(milliseconds: numberOfQuestions * 500),
                    color: Colors.green.shade800,
                    completedColor: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    onEnd: handleProgressBarAnimationEnded,
                    topHint: AnimatedOpacity(
                      opacity: isProgressBarAnimationEnded ? 1 : 0,
                      duration: hintAndLevelDuration,
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
                      duration: hintAndLevelDuration,
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

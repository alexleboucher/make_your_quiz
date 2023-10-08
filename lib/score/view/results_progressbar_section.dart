import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';
import 'package:make_your_quiz/shared/widgets/segmented_linear_progress_indicator.dart';

class ResultsProgressBarSection extends StatefulWidget {
  const ResultsProgressBarSection({
    required this.numberOfQuestions,
    required this.score,
    required this.onAnimationsEnded,
    super.key,
  });

  final int numberOfQuestions;
  final int score;
  final void Function() onAnimationsEnded;

  @override
  State<ResultsProgressBarSection> createState() =>
      _ResultsProgressBarSectionState();
}

class _ResultsProgressBarSectionState extends State<ResultsProgressBarSection> {
  static const hintAndLevelDuration = Duration(milliseconds: 1200);

  bool isProgressBarAnimationEnded = false;
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
      widget.onAnimationsEnded,
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
    final areLevelsValid = levels.length == widget.numberOfQuestions + 1;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SegmentedLinearProgressBar(
          value: widget.score.toDouble() / widget.numberOfQuestions.toDouble(),
          sectionsCount: widget.numberOfQuestions,
          width: 500,
          height: 17,
          constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
          segmentDisabledColor: Colors.grey,
          progressDuration:
              Duration(milliseconds: widget.numberOfQuestions * 500),
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
                  '${widget.score} bonne${widget.score > 1 ? 's' : ''} réponse${widget.score > 1 ? 's' : ''} sur ${widget.numberOfQuestions} question${widget.numberOfQuestions > 1 ? 's' : ''}',
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
    );
  }
}

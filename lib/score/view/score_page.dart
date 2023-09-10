import 'package:flutter/material.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final numberOfQuestions = widget.playQuestions.length;

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
              child: SegmentedLinearProgressBar(
                value: widget.score.toDouble() / numberOfQuestions.toDouble(),
                sectionsCount: numberOfQuestions,
                width: 500,
                height: 15,
                constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
                segmentDisabledColor: Colors.grey,
                progressDuration: const Duration(milliseconds: 1500),
                color: Colors.green.shade800,
                completedColor: Colors.amber.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

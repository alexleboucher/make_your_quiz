import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/model/play_question.dart';
import 'package:make_your_quiz/score/view/questions_summary.dart';
import 'package:make_your_quiz/score/view/results_progressbar_section.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

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
  bool areResultsProgressBarAnimationsEnded = false;
  bool isAlignAnimationEnded = false;

  @override
  Widget build(BuildContext context) {
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
                  'Résultats',
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
              alignment: areResultsProgressBarAnimationsEnded
                  ? Alignment.topCenter
                  : Alignment.center,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 750),
              onEnd: () => setState(() {
                isAlignAnimationEnded = true;
              }),
              child: Column(
                mainAxisSize:
                    isAlignAnimationEnded ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Center(
                    child: ResultsProgressBarSection(
                      numberOfQuestions: widget.playQuestions.length,
                      score: widget.score,
                      onAnimationsEnded: () => setState(() {
                        areResultsProgressBarAnimationsEnded = true;
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: isAlignAnimationEnded ? 1 : 0,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: AnimatedOpacity(
                        opacity: isAlignAnimationEnded ? 1 : 0,
                        duration: const Duration(milliseconds: 1200),
                        child: isAlignAnimationEnded
                            ? Container(
                                constraints: const BoxConstraints.expand(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: QuestionsSummary(
                                    playQuestions: widget.playQuestions,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

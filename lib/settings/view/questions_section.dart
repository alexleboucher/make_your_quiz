import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/model/question.dart';
import 'package:make_your_quiz/settings/view/question_dialog.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class QuestionsSection extends StatefulWidget {
  const QuestionsSection({super.key});

  @override
  State<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends State<QuestionsSection>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  late AnimationController _animationController;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    super.initState();
  }

  final List<Question> _items = List<Question>.generate(
    15,
    (int index) => Question(
      title: 'Question $index',
      goodAnswer: 'Good answer $index',
      otherAnswers: List<String>.generate(
        3,
        (int idx) => 'Other answer $index - $idx',
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: Border.all(color: Colors.transparent),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: AppText(
        'Questions',
        typo: Typo.headlineSmall,
        style: GoogleFonts.ubuntu(fontWeight: FontWeight.w400),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) => const QuestionDialog(),
            ),
            icon: const Icon(Icons.add),
          ),
          RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.expand_more),
          ),
        ],
      ),
      onExpansionChanged: (isExpanded) {
        if (isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      children: [
        const SizedBox(height: 3),
        Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: ReorderableListView(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            children: [
              for (int i = 0; i < _items.length; i++)
                Card(
                  key: Key('$i'),
                  child: ListTile(
                    title: Text(_items[i].title),
                    leading: ReorderableDragStartListener(
                      index: i,
                      child: const Icon(Icons.drag_handle),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => showDialog<dynamic>(
                            context: context,
                            builder: (BuildContext context) => QuestionDialog(
                              question: _items[i],
                            ),
                          ),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _items.removeAt(i);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              });
            },
          ),
        ),
      ],
    );
  }
}

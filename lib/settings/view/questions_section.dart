import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/settings/view/question_dialog.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class QuestionsSection extends StatefulWidget {
  const QuestionsSection({super.key});

  @override
  State<QuestionsSection> createState() => _QuestionsSectionState();
}

class _QuestionsSectionState extends State<QuestionsSection> {
  final List<int> _items = List<int>.generate(15, (int index) => index);

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
      children: [
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
                    title: Text('This is tile number ${_items[i]}'),
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
                            builder: (BuildContext context) =>
                                const QuestionDialog(),
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

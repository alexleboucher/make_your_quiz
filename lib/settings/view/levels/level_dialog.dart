import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/settings/view/levels/level_form.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class LevelDialog extends StatelessWidget {
  const LevelDialog({
    required this.onSubmit,
    this.level,
    super.key,
  });

  final String? level;
  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  level != null ? 'Modifier un niveau' : 'Créer un niveau',
                  typo: Typo.headlineSmall,
                  style: GoogleFonts.ubuntu(),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            LevelForm(
              level: level,
              onSubmit: (level) {
                onSubmit(level);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:make_your_quiz/app/cubit/settings_cubit.dart';
import 'package:make_your_quiz/shared/widgets/app_scaffold.dart';
import 'package:make_your_quiz/shared/widgets/app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final questions =
        context.select((SettingsCubit cubit) => cubit.state.questions);

    final buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.ubuntu(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(18),
      ),
    );

    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              'Make Your Quiz',
              typo: Typo.displayLarge,
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: questions.isEmpty
                        ? null
                        : () => context.beamToNamed('/play'),
                    style: buttonStyle,
                    child: const Text('JOUER'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.beamToNamed('/settings'),
                    style: buttonStyle,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('PARAMETRES'),
                        if (questions.isEmpty) ...[
                          const SizedBox(width: 5),
                          Icon(
                            Icons.error_rounded,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

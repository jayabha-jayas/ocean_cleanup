import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/wobbly_button.dart';
import 'instructions_dialog.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    var t = AppLocalizations.of(context);
    final gameLevels = translatedGameLevels(context);

    return Scaffold(
      backgroundColor: palette.backgroundMain.color,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t?.selectLevel ?? 'Select level',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 16),
                  NesButton(
                    type: NesButtonType.normal,
                    child: NesIcon(iconData: NesIcons.questionMark),
                    onPressed: () {
                      NesDialog.show(
                        context: context,
                        builder: (_) => const InstructionsDialog(),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: WobblyButton(
                              onPressed: playerProgress.levels.length >=
                                      level.number - 1
                                  ? () {
                                      final audioController =
                                          context.read<AudioController>();
                                      audioController
                                          .playSfx(SfxType.buttonTap);

                                      GoRouter.of(context)
                                          .go('/play/session/${level.number}');
                                    }
                                  : null,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Level #${level.number} ${level.name}',
                                      maxLines: 5,
                                      softWrap: true,
                                    ),
                                  ),
                                  if (playerProgress.levels.length <
                                      level.number - 1) ...[
                                    const Expanded(
                                        child: Icon(Icons.lock, size: 20)),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          WobblyButton(
            onPressed: () {
              GoRouter.of(context).go('/');
            },
            child: Text(t?.back ?? 'Back'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

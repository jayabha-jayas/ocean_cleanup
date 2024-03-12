import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ocean_cleanup/level_selection/instructions_dialog.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import '../src/game.dart';
import 'game_over_dialog.dart';
import 'game_win_dialog.dart';

class FlameGameStart extends StatelessWidget {
  FlameGameStart({required this.level, super.key});

  final GameLevel level;
  bool isPaused = false;

  static const String winDialogKey = 'win_dialog';
  static const String backButtonKey = 'back_buttton';
  static const String pauseButtonKey = 'pause_buttton';
  static const String gameOverDialogKey = 'game_over_dialog';
  static const String instructionDialogKey = 'instruction_dialog';

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    return Scaffold(
      body: GameWidget<MainRouterGame>(
        key: const Key('play session'),
        game: MainRouterGame(
          level: level,
          playerProgress: context.read<PlayerProgress>(),
          audioController: audioController,
        ),
        overlayBuilderMap: {
          backButtonKey: (BuildContext context, MainRouterGame game) {
            return Positioned(
              top: 20,
              left: 10,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: GoRouter.of(context).pop,
                child: const Icon(
                  Icons.arrow_back_outlined,
                ),
              ),
            );
          },
          FlameGameStart.pauseButtonKey:
              (BuildContext context, MainRouterGame game) {
            return Positioned(
              top: 20,
              left: 70,
              child: NesButton(
                type: NesButtonType.normal,
                onPressed: () {
                  if (isPaused) {
                    game.router.pop();
                    game.background.start();
                  } else {
                    game.router.pushNamed('pause');
                    game.background.stop();
                  }
                  isPaused = !isPaused;
                },
                child: Image.asset(
                  "assets/icons/pause-play-button.png",
                  height: 24,
                  width: 24,
                ),
              ),
            );
          },
          winDialogKey: (BuildContext context, MainRouterGame game) {
            return GameWinDialog(
              level: level,
              levelCompletedIn: 0,
            );
          },
          gameOverDialogKey: (BuildContext context, MainRouterGame game) {
            return GameOverDialog(
              level: level,
            );
          },
          instructionDialogKey: (BuildContext context, MainRouterGame game) {
            return Positioned(
              top: 20,
              right: 150,
              child: NesButton(
                type: NesButtonType.normal,
                child: NesIcon(iconData: NesIcons.questionMark),
                onPressed: () {
                  NesDialog.show(
                    context: context,
                    builder: (_) => const InstructionsDialog(),
                  );
                },
              ),
            );
          },
        },
      ),
    );
  }
}

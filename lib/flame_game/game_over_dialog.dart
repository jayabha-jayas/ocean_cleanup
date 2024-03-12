import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../level_selection/levels.dart';
import '../style/palette.dart';

/// This dialog is shown when a level is failed.
///
/// It lets the user go back to the level
/// selection screen.
class GameOverDialog extends StatelessWidget {
  const GameOverDialog({
    super.key,
    required this.level,
  });

  /// The properties of the level that was just finished.
  final GameLevel level;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);

    final palette = context.read<Palette>();
    return Center(
      child: NesContainer(
        width: 420,
        height: 600,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: Text(
                t?.oops ?? 'Oops!\n You killed a marine life',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/sad_fish.png",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(width: 16),
                Text(
                  t?.gameOver ?? 'Game Over!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Flexible(
              child: NesButton(
                onPressed: () {
                  context.go('/play');
                },
                type: NesButtonType.normal,
                child: Text(t?.levelSelection ?? 'Level selection'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

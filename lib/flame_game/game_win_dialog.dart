import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_wallet/google_wallet.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../level_selection/levels.dart';
import '../src/models/google_wallet.dart';
import '../style/palette.dart';

class GameWinDialog extends StatefulWidget {
  GameWinDialog({
    super.key,
    required this.level,
    required this.levelCompletedIn,
  }) {
    googleWalletDemo = WalletModel(level: level);
  }

  late final WalletModel googleWalletDemo;

  /// The properties of the level that was just finished.
  final GameLevel level;

  /// How many seconds that the level was completed in.
  final int levelCompletedIn;

  @override
  State<GameWinDialog> createState() => _GameWinDialogState();
}

class _GameWinDialogState extends State<GameWinDialog> {
  bool cardAdded = false;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final palette = context.read<Palette>();
    var locale = Localizations.localeOf(context).toString().substring(0, 2);
    if (locale == "en") {
      locale = "en_US";
    } else if (locale == "ja") {
      locale = "jp";
    }
    final gameLevels = translatedGameLevels(context);
    return Center(
      child: NesContainer(
        width: 500,
        backgroundColor: palette.backgroundPlaySession.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                t?.congratulations ?? 'Congratulations!',
                style: const TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 25,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              t?.completed ?? 'You completed the level',
              // 'You completed level ${level.number} in $levelCompletedIn seconds.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (widget.level.number < gameLevels.length) ...[
              NesButton(
                onPressed: () {
                  context.go('/play/session/${widget.level.number + 1}');
                },
                type: NesButtonType.primary,
                child: Text(t?.nextLevel ?? 'Next level'),
              ),
              const SizedBox(height: 16),
            ],
            NesButton(
              onPressed: () {
                context.go('/play');
              },
              type: NesButtonType.normal,
              child: Text(t?.levelSelection ?? 'Level selection'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GoogleWalletButton(
                style: GoogleWalletButtonStyle.condensed,
                height: 90,
                onPressed: () {
                  bool isJapanese = locale == "jp";
                  widget.googleWalletDemo.savePass(isJapanese: isJapanese);
                },
                locale: Locale(locale),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

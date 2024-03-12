import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../style/palette.dart';
import '../style/wobbly_button.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    var t = AppLocalizations.of(context);
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings.color,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: ListView(
                  children: [
                    _gap,
                    Text(
                      t?.settings ?? 'Settings',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Press Start 2P',
                        fontSize: 30,
                        height: 1,
                      ),
                    ),
                    _gap,
                    _NameChangeLine(
                      t?.name ?? 'Name',
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: settings.soundsOn,
                      builder: (context, soundsOn, child) => SettingsLine(
                        t?.sound ?? 'Sound FX',
                        Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                        onSelected: () => settings.toggleSoundsOn(),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: settings.musicOn,
                      builder: (context, musicOn, child) => SettingsLine(
                        t?.music ?? 'Music',
                        Icon(musicOn ? Icons.music_note : Icons.music_off),
                        onSelected: () => settings.toggleMusicOn(),
                      ),
                    ),
                    SettingsLine(
                      t?.reset ?? 'Reset progress',
                      const Icon(Icons.delete),
                      onSelected: () {
                        // context.read<PlayerProgress>().reset();

                        final messenger = ScaffoldMessenger.of(context);
                        messenger.showSnackBar(
                          const SnackBar(
                              content: Text('Player progress has been reset.')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            _gap,
            WobblyButton(
              onPressed: () {
                audioController.playSfx(SfxType.buttonTap);
                GoRouter.of(context).pop();
              },
              child: Text(t?.back ?? 'Back'),
            ),
            _gap,
          ],
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;

  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 20,
                )),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: const TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsLine extends StatelessWidget {
  final String title;

  final Widget icon;

  final VoidCallback? onSelected;

  const SettingsLine(this.title, this.icon, {super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Press Start 2P',
                  fontSize: 20,
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}

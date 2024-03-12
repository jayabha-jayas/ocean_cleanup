import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ocean_cleanup/main.dart';
import 'package:ocean_cleanup/utils/context.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../level_selection/instructions_dialog.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../style/wobbly_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();

    final audioController = context.watch<AudioController>();
    var t = AppLocalizations.of(context);
    // final Locale locale = Localizations.localeOf(context);
    // Dropdown options
    var items = [
      {"key": "en", "value": t?.en ?? ""},
      {"key": "ja", "value": t?.ja ?? ""}
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/entangled.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ResponsiveScreen(
          squarishMainArea: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: -0.1,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: NeonText(
                        text: t?.appTitle ?? "Ocean Cleanup",
                        spreadColor: Colors.blue,
                        blurRadius: 20,
                        textSize: context.isSmall ? 20 : 32,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                _gap,
                WobblyButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    //Background Music Off
                    // settingsController.audioOff();
                    audioController.stopAllSound();
                    GoRouter.of(context).go('/knowledge');
                  },
                  child: Text(
                    t?.knowledge ?? 'Knowledge',
                  ),
                ),
                _gap,
                WobblyButton(
                  onPressed: () {
                    audioController.playSfx(SfxType.buttonTap);
                    NesDialog.show(
                      context: context,
                      builder: (_) => const InstructionsDialog(),
                    );
                  },
                  child: Text(
                    t?.instructions ?? 'Instructions',
                  ),
                ),
              ],
            ),
          ),
          rectangularMenuArea: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WobblyButton(
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).go('/play');
                },
                child: Text(t?.playOcean ?? 'Play Oceanista'),
              ),
              _gap,

              WobblyButton(
                onPressed: () {
                  audioController.playSfx(SfxType.buttonTap);
                  GoRouter.of(context).push('/settings');
                },
                child: Text(t?.settings ?? 'Settings'),
              ),
              _gap,
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ValueListenableBuilder<bool>(
                  valueListenable: settingsController.audioOn,
                  builder: (context, audioOn, child) {
                    return IconButton(
                      onPressed: () => settingsController.toggleAudioOn(),
                      icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
                      color: Colors.white,
                    );
                  },
                ),
              ),
              // _gap,
              // Text(
              //   t?.builtBy ?? 'Built By Team Ocean',
              //   style: const TextStyle(
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
          topMessageArea: DropdownButton(
            // Down Arrow Icon
            icon: Row(
              children: [
                const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                Text(
                  t?.language ?? "Language",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            items: items.map((Map<String, String> item) {
              return DropdownMenuItem(
                value: item["key"],
                child: Text(item["value"] ?? ""),
              );
            }).toList(),
            onChanged: (String? newValue) {
              MyGame.setLocale(context, Locale(newValue ?? ""));
            },
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: 10);
}

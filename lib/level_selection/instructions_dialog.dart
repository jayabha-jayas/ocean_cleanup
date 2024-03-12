import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';

class InstructionsDialog extends StatefulWidget {
  const InstructionsDialog({super.key});

  @override
  State<InstructionsDialog> createState() => _InstructionsDialogState();
}

class _InstructionsDialogState extends State<InstructionsDialog> {
  final _pageController = PageController();
  late int _currentPage = _pageController.initialPage;

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final audioController = context.watch<AudioController>();
    return Column(
      children: [
        Text(
          t?.instructions ?? 'Instructions',
          style: TextStyle(
            fontFamily: GoogleFonts.pressStart2p().fontFamily,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            SizedBox(
              width: 30,
              child: _currentPage != 0
                  ? NesIconButton(
                      icon: NesIcons.leftArrowIndicator,
                      onPress: () {
                        audioController.playSfx(SfxType.buttonTap);
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      },
                    )
                  : null,
            ),
            SizedBox(
              width: 350,
              height: 100,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int newPage) {
                  setState(() {
                    _currentPage = newPage;
                  });
                },
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: SpriteAnimationWidget.asset(
                            path: 'plastic_ins.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.20,
                              textureSize: Vector2(95, 346),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 7,
                        child: Text(
                          t?.insOne ?? 'Don\'t kill animals in Ocean.',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 7,
                        child: Text(
                          t?.insTwo ?? 'Drag on screen to collect plastic.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: SpriteAnimationWidget.asset(
                            path: 'starfish_animate.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.15,
                              textureSize: Vector2(165, 185),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child: SpriteAnimationWidget.asset(
                            path: 'octo.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 4,
                              stepTime: 0.15,
                              textureSize: Vector2(30, 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 6,
                        child: Text(
                          t?.insThree ?? 'Help Ocean and its Habitats.',
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 7,
                        child: Text(
                          t?.insFour ??
                              'Collect fishing nets, hooks,  plastics from ocean.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: SpriteAnimationWidget.asset(
                            path: 'octo_goggles.png',
                            data: SpriteAnimationData.sequenced(
                              amount: 5,
                              stepTime: 0.15,
                              textureSize: Vector2(150, 190),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 30,
                child: _currentPage != 3
                    ? NesIconButton(
                        icon: NesIcons.rightArrowIndicator,
                        onPress: () {
                          audioController.playSfx(SfxType.buttonTap);
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                      )
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ocean_cleanup/knowledge/video_on_left.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import '../style/wobbly_button.dart';
import 'video_on_right.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final _pageController = PageController();

  static const _gap = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    final palette = context.watch<Palette>();
    final settings = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      backgroundColor: palette.mainScreenBlue.color,
      body: Column(
        children: [
          _gap,
          Text(
            t?.knowledge ?? 'Knowledge',
            style: TextStyle(
              fontSize: 35,
              color: palette.mainScreenWhiteText.color,
              fontFamily: GoogleFonts.daiBannaSil().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                SafeArea(
                  child: NesIconButton(
                    icon: NesIcons.leftArrowIndicator,
                    onPress: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int newPage) {
                      setState(() {
                        // _currentPage = newPage;
                      });
                    },
                    children: [
                      VideoOnLeftKnowledge(
                        pageNumber: 1,
                        videoId: 'cEeKerZ7iU4',
                        heading: "# ${t?.theGreatPacific}",
                        content: "${t?.pageOneContent}",
                        credits:
                            '${t?.videoCourtesy ?? "Video Courtesy"} : Destination Tips',
                      ),
                      VideoOnRightKnowledge(
                        pageNumber: 2,
                        videoId: '',
                        isImage: true,
                        imagePath: "plastic_in_stomach.png",
                        heading: "# ${t?.effectsOnMarianeLife} - ${t?.food}",
                        content: "${t?.pageTwoContent}",
                        credits: '${t?.pictureCredits}: theoceancleanup.com',
                      ),
                      VideoOnLeftKnowledge(
                        pageNumber: 3,
                        videoId: 'CuSg6TSdvXY',
                        heading:
                            "# ${t?.effectsOnMarianeLife} - ${t?.entanglement}",
                        content: "${t?.pageThreeContent}",
                        credits:
                            '${t?.videoCourtesy ?? "Video Courtesy"} : Ocean Conservation Namibia',
                      ),
                      VideoOnRightKnowledge(
                        pageNumber: 4,
                        videoId: '',
                        imagePath: "garbage_truck.gif",
                        isImage: true,
                        heading: "# ${t?.individualHelp} ",
                        content: "${t?.pageFourContent}",
                        credits: '${t?.pictureCredits} : Oceanea',
                      ),
                      VideoOnLeftKnowledge(
                        pageNumber: 5,
                        videoId: 'L8pEdHzQcik',
                        heading: "# ${t?.giantBarriers} ",
                        content: "${t?.pageFiveContent}",
                        credits:
                            '${t?.videoCourtesy ?? "Video Courtesy"} : Business Insider',
                      ),
                      VideoOnRightKnowledge(
                        pageNumber: 6,
                        videoId: '',
                        isImage: true,
                        imagePath: "cleanup.gif",
                        heading: "# ${t?.moreNonProfit}",
                        content:
                            " Ocean Conservation Namibia\n Team Seas \n The Ocean Cleanup \n 4Ocean \n Oceana ",
                        credits: "${t?.pictureCredits} : theoceancleanup.com",
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: NesIconButton(
                    icon: NesIcons.rightArrowIndicator,
                    onPress: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          WobblyButton(
            onPressed: () {
              //Background Music On
              if (settings.audioOn.value) {
                audioController.startOrResumeMusic();
              }

              audioController.playSfx(SfxType.buttonTap);

              GoRouter.of(context).pop();
            },
            child: Text(t?.back ?? 'Back'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

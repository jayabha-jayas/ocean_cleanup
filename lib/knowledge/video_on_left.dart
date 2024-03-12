import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../style/palette.dart';

class VideoOnLeftKnowledge extends StatefulWidget {
  final int pageNumber;
  final String videoId;
  final String heading;
  final String content;
  final String credits;
  final String imagePath;
  final bool isImage;

  const VideoOnLeftKnowledge({
    super.key,
    required this.pageNumber,
    required this.videoId,
    required this.heading,
    required this.content,
    required this.credits,
    this.isImage = false,
    this.imagePath = "",
  });

  @override
  State<VideoOnLeftKnowledge> createState() => _VideoOnLeftKnowledgeState();
}

class _VideoOnLeftKnowledgeState extends State<VideoOnLeftKnowledge> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    return Scaffold(
      backgroundColor: palette.mainScreenBlue.color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Text(
                widget.heading,
                style: TextStyle(
                  fontSize: 22,
                  color: palette.mainScreenBlackText.color,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.daiBannaSil().fontFamily,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.videoId.isNotEmpty
                      ? Expanded(
                          child: YoutubePlayer(
                            backgroundColor: palette.mainScreenBlackText.color,
                            controller: _controller,
                          ),
                        )
                      : const SizedBox.shrink(),
                  widget.isImage
                      ? Expanded(
                          child: Image.asset(
                            "assets/images/${widget.imagePath}",
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 20),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: palette.mainScreenWhiteText.color,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: palette.mainScreenBlackText.color,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          fontFamily: GoogleFonts.daiBannaSil().fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: palette.mainScreenBlackText.color,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Text(
              widget.credits,
              style: TextStyle(
                color: palette.mainScreenWhiteText.color,
                fontSize: 15,
                fontFamily: GoogleFonts.daiBannaSil().fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

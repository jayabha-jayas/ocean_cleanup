import 'dart:async' as async;
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart' as material;
import 'package:shared_preferences/shared_preferences.dart';

class TypingNarrative extends PositionComponent with TapCallbacks {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences preferences;

  List<String> narrativeArray = [
    "Welcome to Ocean Cleanup Game!",
    "Embark on a mission to rescue the oceans from plastic pollution.",
    "The oceans are in danger and need your help.",
  ];

  late SpriteComponent image;

  late String displayedText;
  late int textIndex;
  late bool typingComplete;

  bool allTextDisplayed = false;
  int currentIndexOfNarrative = 0;

  TypingNarrative(Image scroll) {
    size = Vector2(800, 800);

    image = SpriteComponent.fromImage(
      scroll,
      size: Vector2(300, 250),
      anchor: Anchor.bottomCenter,
    );
    image.width = 800;
    displayedText = '';
    textIndex = 0;
    typingComplete = false;

    currentIndexOfNarrative = 0;
    startTyping(narrativeArray[currentIndexOfNarrative]);
  }

  @override
  void render(Canvas canvas) {
    image.render(canvas);
    double maxWidth = image.width - 200;

    final material.TextPainter tp = material.TextPainter(
      text: material.TextSpan(
        text: displayedText,
        style: const material.TextStyle(
            color: material.Colors.black,
            fontSize: 25.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            fontFamily: "VictorianSecret"),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 5,
    );

    tp.layout(maxWidth: maxWidth);
    double x = this.x + (image.width - tp.width) / 2;
    double y = this.y + (image.height - tp.height) / 2;

    tp.paint(canvas, Offset(x, y));
  }

  @override
  void onTapUp(TapUpEvent event) {
    currentIndexOfNarrative++;
    if (currentIndexOfNarrative < narrativeArray.length) {
      allTextDisplayed = false;
      startTyping(narrativeArray[currentIndexOfNarrative]);
    } else {
      parent?.remove(this);
      displayedText = "";
      typingComplete = true;
      setNarrative();
    }
    if (!allTextDisplayed) {
      displayedText = narrativeArray[currentIndexOfNarrative];
      allTextDisplayed = true;
    }
  }

  Future<void> setNarrative() async {
    preferences = await _prefs;
    preferences.setBool("narrative", true);
  }

  void startTyping(String narrativeText) {
    textIndex = 0;
    late async.Timer typingTimer;
    typingTimer =
        async.Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (textIndex < narrativeText.length) {
        displayedText = narrativeText.substring(0, textIndex + 1);
        textIndex++;
      } else {
        typingTimer.cancel();
      }
    });
  }
}

import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/parallax.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart' as material;
import 'package:ocean_cleanup/src/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/narrative.dart';
import '../components/rounded_button.dart';

class HomePage extends Component with HasGameReference<MainRouterGame> {
  late RoundedButton _button1;
  late SpriteComponent scrollSprite;
  TextComponent? _scoreTextComponent;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences preferences;
  bool _isButtonOneAdded = false;
  late TypingNarrative imageWithText;
  late SpriteComponent trophySprite;

  // WalletModel googleWalletDemo = WalletModel();
  bool isTrophySpriteInitialized = false;
  late ParallaxComponent imageComponent;

  @override
  void update(double dt) async {
    super.update(dt);
    _scoreTextComponent?.text = "${await getCount()}";
    bool isNarrativeDone = await checkIfNarrativeIsDone();

    if (isNarrativeDone && !_isButtonOneAdded) {
      _isButtonOneAdded = true;
      add(
        _button1 = RoundedButton(
          text: "Start",
          onPressed: () {
            game.router.pushNamed('game-page');
          },
          color: material.Colors.transparent,
          borderColor: material.Colors.white,
        ),
      );
    }
  }

  @override
  void onLoad() async {
    super.onLoad();

    add(imageComponent = ParallaxComponent(
      parallax: Parallax(
        [
          await ParallaxLayer.load(
            ParallaxImageData('bg1.jpg'),
            fill: LayerFill.width,
          ),
        ],
      ),
    ));

    final Image scroll = await game.images.load('scroll.png');

    bool isDone = await checkIfNarrativeIsDone();

    imageWithText = TypingNarrative(scroll);

    if (!isDone) {
      add(imageWithText);
    }
    final trophy = await game.images.load('trophy.png');

    trophySprite = SpriteComponent.fromImage(
      trophy,
      position: Vector2(0, 0),
      size: Vector2(50, 50),
      anchor: Anchor.topRight,
    );

    addAll([
      _scoreTextComponent = TextComponent(
        text: "${await getCount()}",
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 30,
              color: material.Colors.orange,
              fontWeight: FontWeight.bold),
        ),
        position: Vector2(0, 0),
        anchor: Anchor.topRight,
      ),
      trophySprite,
    ]);
    isTrophySpriteInitialized = true;
    await checkWallet();
  }

  Future<void> checkWallet() async {
    preferences = await _prefs;
    int score = preferences.getInt('score') ?? 0;
    if (score > 50) {
      // final gw = GoogleWalletButtonV2(
      //     text: "Add to google wallet",
      //     onPressed: googleWalletDemo.savePass,
      //     color: const Color(0xFF000EEE),
      //     borderColor: const Color(0xFF000000));
      // add(gw);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_isButtonOneAdded == true) {
      _button1.position = size / 2;
    }

    if (isTrophySpriteInitialized) {
      trophySprite.position = Vector2(size.x - 40, 5);
      trophySprite.size = Vector2(50, 50);
      _scoreTextComponent?.position = Vector2(game.size.x - 10, 10);
    }
  }

  Future<int> getCount() async {
    preferences = await _prefs;
    return preferences.getInt('score') ?? 0;
  }

  Future<bool> checkIfNarrativeIsDone() async {
    preferences = await _prefs;
    return preferences.getBool("narrative") ?? false;
  }
}

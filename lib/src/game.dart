import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ocean_cleanup/src/config/app_config.dart';
import 'package:ocean_cleanup/src/models/fruit_model.dart';
import 'package:ocean_cleanup/src/routes/game_over_page.dart';
import 'package:ocean_cleanup/src/routes/game_page.dart';
import 'package:ocean_cleanup/src/routes/home_page.dart';
import 'package:ocean_cleanup/src/routes/pause_game.dart';

import '../audio/audio_controller.dart';
import '../flame_game/components/background.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';

class MainRouterGame extends FlameGame {
  MainRouterGame({
    required this.audioController,
    required this.level,
    required this.playerProgress,
  });

  final GameLevel level;
  final PlayerProgress playerProgress;
  late Background background;

  late final RouterComponent router;
  late double maxVerticalVelocity;

  final AudioController audioController;

  final List<FruitModel> fruits = [
    FruitModel(image: "pepsi.png"),
    FruitModel(image: "jelly.png", isBomb: true),
    FruitModel(image: "bottle_empty.png"),
    FruitModel(image: "poly.webp"),
    FruitModel(image: "cd.png"),
    FruitModel(image: "container.png"),
    FruitModel(image: "star.png", isBomb: true),
    // FruitModel(image: "ally.png", isBomb: true),
    FruitModel(image: "helly.png", isBomb: true),

    FruitModel(image: "red_star.png", isBomb: true),
  ];

  @override
  void onLoad() async {
    super.onLoad();
    await FlameAudio.audioCache
        .loadAll(["fruit_cut.mp3", "bg.mp3", "game_over.mp3"]);
    await images.load('bg1.jpg');

    for (final fruit in fruits) {
      final image = await images.load(fruit.image);
      await fruit.updatePaletteGenerator(image);
    }
    late double speed = _calculateSpeed(level.number);
    add(background = Background(speed: speed,level: level));
    addAll([
      // ParallaxComponent(
      //   parallax: Parallax(
      //     [
      //       await ParallaxLayer.load(
      //         ParallaxImageData('nemo.jpeg'),
      //         fill: LayerFill.width,
      //       ),
      //     ],
      //   ),
      // ),
      router = RouterComponent(initialRoute: 'game-page', routes: {
        'home': Route(HomePage.new),
        'game-page': Route(GamePage.new),
        'pause': PauseRoute(),
        'game-over': GameOverRoute()
      })
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size) {
    maxVerticalVelocity = sqrt(2 *
        (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) *
        (size.y - AppConfig.objSize * 2));
  }

  static double _calculateSpeed(int level) => 100 + (level * 10);
}

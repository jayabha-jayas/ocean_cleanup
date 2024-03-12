import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:ocean_cleanup/flame_game/flame_game_start.dart';
import 'package:ocean_cleanup/src/config/app_config.dart';
import 'package:ocean_cleanup/src/game.dart';
import 'package:ocean_cleanup/src/routes/rain_drop.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/fruit_component.dart';

class GamePage extends Component
    with DragCallbacks, HasGameReference<MainRouterGame> {
  final Random random = Random();
  late List<double> fruitsTime;
  late double time, countDown;
  TextComponent? _countdownTextComponent,
      _mistakeTextComponent,
      _scoreTextComponent;

  bool _countdownFinished = false;
  late int mistakeCount, score;
  late int maxLives;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences preferences;
  late SpriteComponent starComponent;
  late SpriteComponent plasticComponent;
  bool isComponentAdded = false;

  @override
  Future<void> onMount() async {
    super.onMount();
    fruitsTime = [];
    countDown = 3;
    mistakeCount = 0;
    maxLives = 3;
    score = 0;
    time = 0;
    _countdownFinished = false;

    double initTime = 0;

    for (int i = 0; i < 10000; i++) {
      if (i != 0) {
        initTime = fruitsTime.last;
      }
      late double millySecondTime;
      if (i == 0) {
        millySecondTime = random.nextInt(100) / 96;
      } else if (i < 20) {
        millySecondTime = random.nextInt(100) / 20;
      } else if (i < 200) {
        millySecondTime = random.nextInt(100) / 40;
      } else if (i < 400) {
        millySecondTime = random.nextInt(100) / 80;
      } else {
        millySecondTime = random.nextInt(100) / 100;
      }

      final componentTime = random.nextInt(1) + millySecondTime + initTime;
      fruitsTime.add(componentTime);
    }

    game.overlays.add(FlameGameStart.backButtonKey);
    game.overlays.add(FlameGameStart.pauseButtonKey);
    game.overlays.add(FlameGameStart.instructionDialogKey);

    // Load the fish image
    final starImage = await game.images.load('pixel_heart.png');

    // Add a SpriteComponent for the fish image
    starComponent = SpriteComponent.fromImage(
      starImage,
      position: Vector2(game.size.x - 30, 5), // Adjust the position as needed
      size: Vector2(50, 50), // Adjust the size as needed
      anchor: Anchor.topRight,
    );

    // Load the fish image
    final plasticImage = await game.images.load('pepsi.png');

    // Add a SpriteComponent for the fish image
    plasticComponent = SpriteComponent.fromImage(
      plasticImage,
      position: Vector2(game.size.x - 80, 50), // Adjust the position as needed
      size: Vector2(50, 50), // Adjust the size as needed
      anchor: Anchor.topRight,
    );

    addAll([
      _countdownTextComponent = TextComponent(
        text: '${countDown.toInt() + 1}',
        size: Vector2.all(50),
        position: game.size / 2,
        anchor: Anchor.center,
      ),
      starComponent,
      _mistakeTextComponent = TextComponent(
        text: '${maxLives - mistakeCount}',
        // 10 is padding
        position: Vector2(game.size.x - 10, 10),
        anchor: Anchor.topRight,
      ),
      plasticComponent,
      _scoreTextComponent = TextComponent(
        text: '$score / ${game.level.winScore} ',
        position:
            Vector2(game.size.x - 10, _mistakeTextComponent!.position.y + 50),
        anchor: Anchor.topRight,
      ),
    ]);
    isComponentAdded = true;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isComponentAdded) {
      starComponent.position = Vector2(game.size.x - 30, 5);
      plasticComponent.position = Vector2(game.size.x - 80, 50);
      _scoreTextComponent?.position =
          Vector2(game.size.x - 10, _mistakeTextComponent!.position.y + 50);
      _mistakeTextComponent?.position = Vector2(game.size.x - 10, 10);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_countdownFinished) {
      countDown -= dt;

      _countdownTextComponent?.text = (countDown.toInt() + 1).toString();
      if (countDown < 0) {
        _countdownFinished = true;
      }
    } else {
      _countdownTextComponent?.removeFromParent();

      time += dt;

      fruitsTime.where((element) => element < time).toList().forEach((element) {
        final gameSize = game.size;

        double posX = random.nextInt(gameSize.x.toInt()).toDouble();

        Vector2 fruitPosition = Vector2(posX, gameSize.y);
        Vector2 velocity = Vector2(0, game.maxVerticalVelocity);

        final randFruit = game.fruits.random();

        add(FruitComponent(
          this,
          fruitPosition,
          acceleration: AppConfig.acceleration,
          fruit: randFruit,
          size: Vector2.all(90),
          image: game.images.fromCache(randFruit.image),
          pageSize: gameSize,
          velocity: velocity,
        ));
        fruitsTime.remove(element);
      });
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    componentsAtPoint(event.canvasPosition).forEach((element) {
      if (element is FruitComponent) {
        if (element.canDragOnShape) {
          element.touchAtPoint(event.canvasPosition);
        }
      } else {
        game.add(RainSplash(event.canvasPosition, this));
      }
    });
  }

  Future<void> gameOver() async {
    // preferences = await _prefs;
    // int savedScore = preferences.getInt('score') ?? 0;
    // if (savedScore < score) {
    //   preferences.setInt('score', score);
    // }

    game.pauseEngine();
    game.overlays.add(FlameGameStart.gameOverDialogKey);
    // game.router.pushNamed('game-over');
  }

  void addScore(bool canCut) {
    if (canCut) {
      score++;
      _scoreTextComponent?.text = '$score / ${game.level.winScore} ';
      if (score >= game.level.winScore) {
        game.playerProgress.setLevelFinished(1, 0);
        game.pauseEngine();
        game.overlays.add(FlameGameStart.winDialogKey);
      }
    }
  }

  void addMistake() {
    mistakeCount++;
    _mistakeTextComponent?.text = '${maxLives - mistakeCount}';
    if (mistakeCount >= maxLives) {
      // FlameAudio.play('game_over.mp3');
      gameOver();
    }
  }
}

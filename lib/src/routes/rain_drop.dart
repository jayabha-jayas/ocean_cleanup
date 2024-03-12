import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

import 'game_page.dart';

class RainSplash extends SpriteComponent {
  final Vector2 location;
  final GamePage parentComponent;

  RainSplash(this.location, this.parentComponent) : super();

  @override
  Future<void> onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await parentComponent.game.images.load('drop_splash.png'),
      srcSize: Vector2(140.0, 140.0),
    );

    final spriteSize = Vector2(140.0, 140.0);

    final animation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.05, to: 16);
    final component1 = SpriteAnimationComponent(
        scale: Vector2(0.2, 0.2),
        animation: animation,
        position: location,
        size: spriteSize,
        removeOnFinish: true);

    add(component1);
    sprite = spriteSheet.getSpriteById(3);
    Future.delayed(const Duration(milliseconds: 80))
        .then((value) => removeFromParent());
  }
}

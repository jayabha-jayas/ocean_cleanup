import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;

class CloudComponent extends PositionComponent {
  late SpriteComponent image;

  late String displayedText;

  CloudComponent(Image ally) {
    size = Vector2(800, 800);
    image = SpriteComponent.fromImage(
      ally,
      size: Vector2(300, 250),
      anchor: Anchor.bottomCenter,
    );
    image.width = 400;
    displayedText = 'why did you kill me??';
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
    double x = (this.x + (image.width - tp.width) / 2) - 200;
    double y = (this.y + (image.height - tp.height) / 2) - 70;

    tp.paint(canvas, Offset(x, y));
  }
}

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static int getAngleOfTouchPont(
      {required Vector2 center,
      required double initAngle,
      required Vector2 touch}) {
    final touchPoint = touch - center;

    double angle = atan2(touchPoint.y, touchPoint.x);

    angle -= initAngle;
    angle %= 2 * pi;

    return radiansToDegrees(angle).toInt();
  }

  static double radiansToDegrees(double angle) => angle * 180 / pi;

  static List<ui.Color> sampleColorsFromImage() {
    List<ui.Color> sampledColors = [];

    sampledColors.add(Colors.red);
    sampledColors.add(Colors.blue);
    sampledColors.add(Colors.green);
    sampledColors.add(Colors.yellow);
    sampledColors.add(Colors.purple);
    sampledColors.add(Colors.orange);
    sampledColors.add(Colors.purple);
    sampledColors.add(Colors.red);
    sampledColors.add(Colors.blue);
    sampledColors.add(Colors.green);

    return sampledColors;
  }
}

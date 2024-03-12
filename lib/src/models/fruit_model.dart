import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class FruitModel {
  String image;
  bool isBomb;
  Color color;
  List<Color> colors;

  FruitModel({
    required this.image,
    this.isBomb = false,
    this.color = Colors.transparent,
    this.colors = const [],
  });

  Future<void> updatePaletteGenerator(var image) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImage(image);
    var newColors = <Color>[];
    for (var element in paletteGenerator.colors) {
      if (newColors.length < 10) {
        newColors.add(element);
      } else {
        break;
      }
    }
    colors = newColors;
  }
}

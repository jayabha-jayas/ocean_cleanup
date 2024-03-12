import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<GameLevel> translatedGameLevels(BuildContext context) {
  AppLocalizations? t = AppLocalizations.of(context);

  final gameLevels = <GameLevel>[
    (
      number: 1,
      winScore: 10,
      canSpawnTall: false,
      name: t?.theGreatPacific ?? "The Great Pacific Garbage Patch"
    ),
    (
      number: 2,
      winScore: 20,
      canSpawnTall: true,
      name: t?.theIndianOcean ?? "The Indian Ocean Garbage Patch"
    ),
    // (
    //   number: 4,
    //   winScore: 5,
    //   canSpawnTall: true,
    //   levelName: "The North Atlantic garbage patch"
    // ),
    // (
    //   number: 5,
    //   winScore: 5,
    //   canSpawnTall: true,
    //   levelName: "The South Atlantic garbage patch"
    // ),
    // (
    //   number: 6,
    //   winScore: 5,
    //   canSpawnTall: true,
    //   levelName: "The Arctic garbage patch"
    // )
  ];
  return gameLevels;
}

typedef GameLevel = ({
  int number,
  int winScore,
  bool canSpawnTall,
  String name,
});

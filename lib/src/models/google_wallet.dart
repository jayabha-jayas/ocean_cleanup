import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_wallet/google_wallet.dart';
import 'package:ocean_cleanup/src/models/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../level_selection/levels.dart';

class WalletModel {
  WalletModel({required this.level}) {
    _checkAvailable();
  }

  _checkAvailable() async {
    bool? available;
    try {
      available = await googleWallet.isAvailable();
    } on PlatformException {
      debugPrint("Availability: Not Available");
    }
    _available = available;
  }

  final GameLevel level;

  bool? _available = false;

  final googleWallet = GoogleWallet();

  final cardMapWithTokenEnglish = {
    1: whaleJson,
    2: seaHorseJson,
  };
  final cardMapWithTokenJapanese = {
    1: whaleJsonJapanese,
    2: searHorseJapansese
  };

  Future<void> savePass({required bool isJapanese}) async {
    final String currentLevelToken = isJapanese
        ? cardMapWithTokenJapanese[level.number] ?? whaleJsonJapanese
        : cardMapWithTokenEnglish[level.number] ?? whaleJson;
    try {
      if (_available == true) {
        await googleWallet.savePassesJwt(currentLevelToken);
      } else {
        await _savePassBrowser(jwtToken: currentLevelToken);
      }
    } on PlatformException {
      debugPrint("Level Number: ${level.number}");
    }
  }

  _savePassBrowser({required String jwtToken}) async {
    String url = "https://pay.google.com/gp/v/save/$jwtToken";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open Google Wallet via web';
    }
  }
}

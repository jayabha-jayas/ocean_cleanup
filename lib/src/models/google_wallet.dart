import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_wallet/google_wallet.dart';
import 'package:ocean_cleanup/src/models/tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../level_selection/levels.dart';
import 'jwt_jsons.dart';

class WalletModel {
  WalletModel({required this.level}) {
    _checkAvailable();
  }

  _checkAvailable() async {
    bool? available;
    // String text;
    try {
      available = await googleWallet.isAvailable();
      // text = "Google Wallet is available: $available";
    } on PlatformException {
      // text = "Error: '${e.message}'.";
    }
    _available = available;
  }

  final GameLevel level;

  bool? _available = false;

  final googleWallet = GoogleWallet();

  final cardMapWithJwt = {
    1: jwtJson,
    2: jwtJson2,
  };
  final cardMapWithToken = {
    1: jwtToken,
    2: jwtToken2,
  };

  Future<void> savePass() async {
    // bool? saved = false;
    // String text;
    try {
      if (_available == true) {
        debugPrint("Debugging: ${level.number}");
        final String currentLevelToken =
            cardMapWithToken[level.number] ?? jwtToken;
        // saved =
        await googleWallet.savePassesJwt(currentLevelToken);
        // saved = await googleWallet.savePasses(jsonEncode(jwtJson));
        // text = "Pass saved: $saved";
      } else {
        // Wallet unavailable,
        // fall back to saving pass via web
        await _savePassBrowser();
        // text = "Opened Google Wallet via web";
      }
    } on PlatformException {
      // text = "Error: '${e.message}'.";
    }
  }

  _savePassBrowser() async {
    String url = "https://pay.google.com/gp/v/save/$jwtToken";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open Google Wallet via web';
    }
  }
}

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:ocean_cleanup/collections/collections.dart';
import 'package:provider/provider.dart';

import 'app_lifecycle/app_lifecycle.dart';
import 'audio/audio_controller.dart';
import 'player_progress/player_progress.dart';
import 'router.dart';
import 'settings/settings.dart';
import 'style/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(const MyGame());
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyGameState? state = context.findAncestorStateOfType<_MyGameState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => Palette()),
          ChangeNotifierProvider(create: (context) => PlayerProgress()),
          Provider(create: (context) => SettingsController()),
          Provider(create: (context) => CollectionsController()),
          // Set up audio.
          ProxyProvider2<SettingsController,
              AppLifecycleStateNotifier,
              AudioController>(
            // Ensures that music starts immediately.
            lazy: false,
            create: (context) => AudioController(),
            update: (context, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
        ],
        child: Builder(builder: (context) {
          final palette = context.watch<Palette>();

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Ocean Cleanup",
            theme: flutterNesTheme().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.seed.color,
                background: palette.backgroundMain.color,
              ),
              textTheme: GoogleFonts.pressStart2pTextTheme().apply(
                bodyColor: palette.text.color,
                displayColor: palette.text.color,
              ),
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate
            ],
            locale: _locale,
            supportedLocales: const [
              // 'en' is the language code. We could optionally provide a
              // country code as the second param, e.g.
              // Locale('en', 'US'). If we do that, we may want to
              // provide an additional app_en_US.arb file for
              // region-specific translations.
              Locale('en', ''),
              Locale('ja', ''),
            ],
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        }),
      ),
    );
  }
}

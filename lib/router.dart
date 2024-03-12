import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:ocean_cleanup/flame_game/flame_game_start.dart';
import 'package:provider/provider.dart';

import 'collections/collections_screen.dart';
import 'knowledge/knowledge_screen.dart';
import 'level_selection/level_selection_screen.dart';
import 'level_selection/levels.dart';
import 'main_menu/main_menu_screen.dart';
import 'settings/settings_screen.dart';
import 'style/page_transition.dart';
import 'style/palette.dart';

/// The router describes the game's navigational hierarchy, from the main
/// screen through settings screens all the way to each individual level.
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
      routes: [
        GoRoute(
          path: 'play',
          pageBuilder: (context, state) => buildPageTransition<void>(
            key: const ValueKey('play'),
            color: context.watch<Palette>().seed.color,
            child: const LevelSelectionScreen(
              key: Key('level selection'),
            ),
          ),
          routes: [
            GoRoute(
              path: 'session/:level',
              pageBuilder: (context, state) {
                final levelNumber = int.parse(state.pathParameters['level']!);
                final gameLevels = translatedGameLevels(context);

                final level = gameLevels[levelNumber - 1];
                return buildPageTransition<void>(
                  key: const ValueKey('level'),
                  color: context.watch<Palette>().backgroundPlaySession.color,
                  child: FlameGameStart(level: level),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(
            key: Key('settings'),
          ),
        ),
        GoRoute(
          path: 'collections',
          builder: (context, state) => const CollectionsScreen(
            key: Key('collections'),
          ),
        ),
        GoRoute(
          path: 'knowledge',
          builder: (context, state) => const KnowledgeScreen(
            key: Key('knowledge'),
          ),
        ),
      ],
    ),
  ],
);

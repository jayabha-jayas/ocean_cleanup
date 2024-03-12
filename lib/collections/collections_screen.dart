import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../settings/settings_screen.dart';
import '../style/palette.dart';
import '../style/wobbly_button.dart';
import 'collections.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  List<String> cards = [];
  late CollectionsController collections;

  @override
  void initState() {
    // initialiseCards();
    super.initState();
  }

  // void initialiseCards() async {
  //   cards = await collections.getCards();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    var t = AppLocalizations.of(context);
    collections = context.watch<CollectionsController>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings.color,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: ListView(
                  children: [
                    CollectionsScreen._gap,
                    Text(
                      t?.collections ?? 'Collections',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Press Start 2P',
                        fontSize: 20,
                        height: 1,
                      ),
                    ),
                    CollectionsScreen._gap,
                    FutureBuilder(
                        future: collections.getCards(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          cards = snapshot.data as List<String>;
                          // builder: (context) {
                          return cards.isNotEmpty
                              ? GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: cards.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        debugPrint(
                                            "Debugging: ${cards[index]}");
                                        // GoRouter.of(context)
                                        //     .go('/collections/${cards[index]}');
                                      },
                                      child: Container(
                                        color:
                                            palette.mainScreenWhiteText.color,
                                        child: Center(
                                          child: Text(
                                            cards[index],
                                            style: const TextStyle(
                                              fontFamily: 'Press Start 2P',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: GestureDetector(
                                      onTap: () async {
                                        collections.setCard("New Card 2");
                                        cards = await collections.getCards();
                                        setState(() {});
                                      },
                                      child: const Text(
                                          "No cards found, Click to add one")));
                        }),
                  ],
                ),
              ),
            ),
            SettingsLine(
              t?.reset ?? 'Reset Collectables',
              const Icon(Icons.delete),
              onSelected: () {
                context.read<CollectionsController>().reset();
                setState(() {
                  cards = [];
                });
                final messenger = ScaffoldMessenger.of(context);
                messenger.showSnackBar(
                  const SnackBar(
                      content: Text('Player progress has been reset.')),
                );
              },
            ),
            CollectionsScreen._gap,
            WobblyButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: Text(t?.back ?? 'Back'),
            ),
            CollectionsScreen._gap,
          ],
        ),
      ),
    );
  }
}

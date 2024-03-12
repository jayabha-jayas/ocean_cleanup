import 'package:shared_preferences/shared_preferences.dart';

import 'collections_persistence.dart';

/// An implementation of [CollectionsPersistence] that uses
/// `package:shared_preferences`.
class LocalStorageCollectionsPersistence extends CollectionsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<List<String>> getCards() async {
    final prefs = await instanceFuture;
    return prefs.getStringList('cards') ?? [];
  }

  @override
  Future<List<String>> getCardAtPosition({required int position}) async {
    final prefs = await instanceFuture;
    final List<String>? list = prefs.getStringList('cards');
    if (list == null || list.isEmpty) {
      return [];
    } else {
      return [list[position]];
    }
  }

  @override
  Future<void> saveCards(List<String> value) async {
    final prefs = await instanceFuture;
    await prefs.setStringList('cards', value);
  }

  @override
  Future<void> saveCard({required String value}) async {
    final prefs = await instanceFuture;
    final cards = prefs.getStringList('cards') ?? [];
    cards.add(value);
    await prefs.setStringList('cards', cards);
  }
  @override
  void reset() async {
    final prefs = await instanceFuture;
    await prefs.clear();
  }
}

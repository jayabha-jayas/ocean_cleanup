import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:ocean_cleanup/collections/persistence/collections_persistence.dart';
import 'package:ocean_cleanup/collections/persistence/local_storage_collections_persistence.dart';

class CollectionsController {
  static final _log = Logger('CollectionsController');

  final CollectionsPersistence _store;

  ValueNotifier<List<String>> cards = ValueNotifier([]);
  ValueNotifier<List<String>> cardAtPosition = ValueNotifier([]);
  ValueNotifier<String> card = ValueNotifier('');

  CollectionsController({CollectionsPersistence? store})
      : _store = store ?? LocalStorageCollectionsPersistence() {
    _loadStateFromPersistence();
  }

  Future<void> setCard(String value) async {
    final List<String> existingCards = await _store.getCards();
    if (existingCards.contains(value)) {
      return;
    }
    card.value = value;
    _store.saveCard(value: card.value);
  }

  void setCards(List<String> value) {
    cards.value = value;
    _store.saveCards(cards.value);
  }

  void setCardAtPosition(int position) {
    cardAtPosition.value = [cards.value[position]];
  }

  Future<List<String>> getCards() async {
    return await _store.getCards();
  }

  Future<void> _loadStateFromPersistence() async {
    final loadedValues = await Future.wait([
      _store.getCards().then((value) => cards.value = value),
      _store
          .getCardAtPosition(position: 0)
          .then((value) => cardAtPosition.value = value),
    ]);

    _log.fine(() => 'Loaded Collections: $loadedValues');
  }
  reset() {
    _store.reset();
    cards.value = [];
    cardAtPosition.value = [];
    card.value = '';
  }
}

// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'collections_persistence.dart';

/// An in-memory implementation of [CollectionsPersistence].
/// Useful for testing.
class MemoryOnlyCollectionsPersistence implements CollectionsPersistence {
  List<String> cards = [];

  @override
  Future<List<String>> getCards() async => cards;

  @override
  Future<List<String>> getCardAtPosition({required int position}) async =>
      [cards[position]];

  @override
  Future<void> saveCards(List<String> value) async => cards = value;

  @override
  Future<void> saveCard({required String value}) async => cards.add(value);

  @override
  void reset() {
    cards = [];
  }
}

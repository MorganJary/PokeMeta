import 'package:pokemeta/models/card_model.dart';

class DeckCardEntry {
  const DeckCardEntry({required this.card, required this.count});

  final CardModel card;
  final int count;
}

class DeckModel {
  const DeckModel({
    required this.name,
    required this.format,
    required this.cards,
  });

  final String name;
  final String format;
  final List<DeckCardEntry> cards;

  int get cardCount => cards.fold(0, (total, entry) => total + entry.count);
}

final sampleDecks = [
  DeckModel(
    name: 'Infernal Reign',
    format: 'Estándar',
    cards: [
      DeckCardEntry(card: sampleCards[0], count: 3),
      DeckCardEntry(card: sampleCards[3], count: 4),
      DeckCardEntry(card: sampleCards[1], count: 2),
    ],
  ),
  DeckModel(
    name: 'Moonlight Control',
    format: 'Estándar',
    cards: [
      DeckCardEntry(card: sampleCards[2], count: 2),
      DeckCardEntry(card: sampleCards[3], count: 4),
      DeckCardEntry(card: sampleCards[1], count: 2),
    ],
  ),
  DeckModel(
    name: 'Thunder Circuit',
    format: 'Expandido',
    cards: [
      DeckCardEntry(card: sampleCards[1], count: 4),
      DeckCardEntry(card: sampleCards[2], count: 2),
      DeckCardEntry(card: sampleCards[0], count: 2),
    ],
  ),
];

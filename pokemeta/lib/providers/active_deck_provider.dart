import 'package:flutter/foundation.dart';
import 'package:pokemeta/models/card_model.dart';
import 'package:pokemeta/models/deck_model.dart';

/// Estado global del mazo que el usuario está armando.
///
/// Extiende ChangeNotifier: cada vez que el mazo cambia llama a
/// notifyListeners(), y las pantallas que lo observan se redibujan solas.
class ActiveDeckProvider extends ChangeNotifier {
  static const int maxCards = 60;

  /// Regla simplificada: máximo 4 copias por carta (en el juego real las
  /// energías básicas no tienen este límite).
  static const int maxCopies = 4;

  // Clave: número de carta (único). Valor: la carta y cuántas copias hay.
  final Map<String, DeckCardEntry> _entries = {};

  /// Copia de solo lectura: desde afuera no se puede modificar la lista.
  List<DeckCardEntry> get entries => List.unmodifiable(_entries.values);

  bool get isEmpty => _entries.isEmpty;

  int get totalCards =>
      _entries.values.fold(0, (total, entry) => total + entry.count);

  int copiesOf(CardModel card) => _entries[card.cardNumber]?.count ?? 0;

  bool canAdd(CardModel card) =>
      totalCards < maxCards && copiesOf(card) < maxCopies;

  void add(CardModel card) {
    if (!canAdd(card)) return;
    _entries[card.cardNumber] = DeckCardEntry(
      card: card,
      count: copiesOf(card) + 1,
    );
    notifyListeners();
  }

  void remove(CardModel card) {
    final copies = copiesOf(card);
    if (copies == 0) return;
    if (copies == 1) {
      _entries.remove(card.cardNumber);
    } else {
      _entries[card.cardNumber] = DeckCardEntry(
        card: card,
        count: copies - 1,
      );
    }
    notifyListeners();
  }

  void clear() {
    if (_entries.isEmpty) return;
    _entries.clear();
    notifyListeners();
  }
}

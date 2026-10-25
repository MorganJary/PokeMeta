import 'package:flutter/material.dart';
import 'package:pokemeta/models/deck_model.dart';
import 'package:pokemeta/presentation/screens/cards/card_detail_screen.dart';
import 'package:pokemeta/widgets/card_image.dart';
import 'package:pokemeta/widgets/stat_badge_widget.dart';

class DeckDetailScreen extends StatelessWidget {
  const DeckDetailScreen({super.key, required this.deck});

  final DeckModel deck;

  @override
  Widget build(BuildContext context) {
    final pokemonCount = deck.cards
        .where((entry) => entry.card.type != 'Entrenador')
        .fold(0, (total, entry) => total + entry.count);
    final typeCount = deck.cards.map((entry) => entry.card.type).toSet().length;

    return Scaffold(
      appBar: AppBar(title: Text(deck.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(deck.format, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Text(
            'Contenido del mazo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatBadgeWidget(value: '${deck.cardCount}', label: 'Cartas'),
                  StatBadgeWidget(value: '$pokemonCount', label: 'Pokémon'),
                  StatBadgeWidget(value: '$typeCount', label: 'Tipos'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Cartas', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          for (final entry in deck.cards)
            Card(
              child: ListTile(
                leading: SizedBox(
                  width: 40,
                  height: 56,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CardImage(card: entry.card, iconSize: 24),
                  ),
                ),
                title: Text(entry.card.name),
                subtitle: Text('${entry.card.type} · ${entry.card.expansion}'),
                trailing: Text('×${entry.count}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => CardDetailScreen(card: entry.card),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

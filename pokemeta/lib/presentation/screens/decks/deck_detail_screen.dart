import 'package:flutter/material.dart';
import 'package:pokemeta/models/deck_model.dart';

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
                  _DeckStat(value: '${deck.cardCount}', label: 'Cartas'),
                  _DeckStat(value: '$pokemonCount', label: 'Pokémon'),
                  _DeckStat(value: '$typeCount', label: 'Tipos'),
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
                leading: const Icon(Icons.image_outlined),
                title: Text(entry.card.name),
                subtitle: Text('${entry.card.type} · ${entry.card.expansion}'),
                trailing: Text('×${entry.count}'),
              ),
            ),
        ],
      ),
    );
  }
}

class _DeckStat extends StatelessWidget {
  const _DeckStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

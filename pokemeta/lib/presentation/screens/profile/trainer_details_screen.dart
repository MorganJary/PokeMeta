import 'package:flutter/material.dart';
import 'package:pokemeta/models/card_model.dart';
import 'package:pokemeta/models/deck_model.dart';
import 'package:pokemeta/presentation/screens/cards/card_detail_screen.dart';
import 'package:pokemeta/presentation/screens/decks/deck_detail_screen.dart';

class TrainerDetailsScreen extends StatelessWidget {
  const TrainerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mostUsedDeck = sampleDecks.first;
    final favoriteCard = sampleCards.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Datos del entrenador')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Estadísticas personales',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.style_outlined),
              title: const Text('Mazo más utilizado'),
              subtitle: Text('${mostUsedDeck.name} · ${mostUsedDeck.format}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => DeckDetailScreen(deck: mostUsedDeck),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Carta favorita'),
              subtitle: Text('${favoriteCard.name} · ${favoriteCard.type}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => CardDetailScreen(card: favoriteCard),
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

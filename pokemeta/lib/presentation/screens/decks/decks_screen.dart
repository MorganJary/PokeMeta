import 'package:flutter/material.dart';
import 'package:pokemeta/models/deck_model.dart';
import 'package:pokemeta/presentation/screens/decks/deck_detail_screen.dart';

class DecksScreen extends StatelessWidget {
  const DecksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Mis mazos', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Nuevo mazo'),
          ),
        ),
        const SizedBox(height: 8),
        for (final deck in sampleDecks)
          Card(
            child: ListTile(
              leading: const Icon(Icons.style_outlined, size: 40),
              title: Text(deck.name),
              subtitle: Text(
                '${deck.format} · ${deck.cardCount}/60 cartas · '
                '${deck.cards.length} tipos de carta',
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {},
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Editar')),
                  PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => DeckDetailScreen(deck: deck),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

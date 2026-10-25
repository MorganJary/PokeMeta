import 'package:flutter/material.dart';
import 'package:pokemeta/providers/active_deck_provider.dart';
import 'package:provider/provider.dart';

/// Muestra y permite ajustar el mazo que se está armando.
class ActiveDeckScreen extends StatelessWidget {
  const ActiveDeckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // watch: esta pantalla se redibuja cada vez que el mazo cambia.
    final deck = context.watch<ActiveDeckProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mazo activo'),
        actions: [
          IconButton(
            onPressed: deck.isEmpty ? null : deck.clear,
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Vaciar mazo',
          ),
        ],
      ),
      body: deck.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Aún no agregaste cartas. Abre una carta del catálogo y '
                  'pulsa "Agregar al mazo activo".',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${deck.totalCards} de ${ActiveDeckProvider.maxCards} cartas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                for (final entry in deck.entries)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.image_outlined),
                      title: Text(entry.card.name),
                      subtitle: Text(
                        '${entry.card.type} · ${entry.card.expansion}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => deck.remove(entry.card),
                            icon: const Icon(Icons.remove_circle_outline),
                            tooltip: 'Quitar una copia',
                          ),
                          Text('${entry.count}'),
                          IconButton(
                            onPressed: deck.canAdd(entry.card)
                                ? () => deck.add(entry.card)
                                : null,
                            icon: const Icon(Icons.add_circle_outline),
                            tooltip: 'Agregar una copia',
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

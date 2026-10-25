import 'package:flutter/material.dart';
import 'package:pokemeta/models/deck_model.dart';
import 'package:pokemeta/presentation/screens/cards/card_detail_screen.dart';
import 'package:pokemeta/presentation/screens/decks/deck_form_screen.dart';
import 'package:pokemeta/widgets/card_image.dart';
import 'package:pokemeta/widgets/stat_badge_widget.dart';

/// Detalle de un mazo. Ahora es StatefulWidget porque el mazo mostrado
/// puede cambiar al editarlo desde esta misma pantalla.
class DeckDetailScreen extends StatefulWidget {
  const DeckDetailScreen({super.key, required this.deck, this.onUpdated});

  final DeckModel deck;

  /// Aviso opcional hacia quien abrió esta pantalla (la lista de mazos),
  /// para que también refleje el mazo editado.
  final ValueChanged<DeckModel>? onUpdated;

  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  late DeckModel _deck;

  @override
  void initState() {
    super.initState();
    _deck = widget.deck;
  }

  Future<void> _edit() async {
    final result = await Navigator.of(context).push<DeckModel>(
      MaterialPageRoute<DeckModel>(
        builder: (context) => DeckFormScreen(deck: _deck),
      ),
    );

    if (result == null || !mounted) return;

    setState(() => _deck = result);
    widget.onUpdated?.call(result);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Mazo actualizado')));
  }

  @override
  Widget build(BuildContext context) {
    final deck = _deck;
    final pokemonCount = deck.cards
        .where((entry) => entry.card.type != 'Entrenador')
        .fold(0, (total, entry) => total + entry.count);
    final typeCount = deck.cards.map((entry) => entry.card.type).toSet().length;

    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name),
        actions: [
          IconButton(
            onPressed: _edit,
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar mazo',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(deck.format, style: Theme.of(context).textTheme.labelLarge),
          if (deck.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(deck.description),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: _edit,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Editar mazo'),
            ),
          ),
          const SizedBox(height: 16),
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
          if (deck.cards.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.inbox_outlined),
                title: Text('Este mazo aún no tiene cartas'),
                subtitle: Text('Cuando agregues cartas, aparecerán aquí.'),
              ),
            )
          else
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
                  subtitle: Text(
                    '${entry.card.type} · ${entry.card.expansion}',
                  ),
                  trailing: Text('×${entry.count}'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) =>
                            CardDetailScreen(card: entry.card),
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

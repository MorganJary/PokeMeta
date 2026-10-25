import 'package:flutter/material.dart';
import 'package:pokemeta/models/deck_model.dart';
import 'package:pokemeta/presentation/screens/decks/deck_detail_screen.dart';
import 'package:pokemeta/presentation/screens/decks/deck_form_screen.dart';

/// Lista de mazos del usuario. Es StatefulWidget porque la lista cambia
/// (se agregan y editan mazos).
class DecksScreen extends StatefulWidget {
  const DecksScreen({super.key});

  @override
  State<DecksScreen> createState() => _DecksScreenState();
}

class _DecksScreenState extends State<DecksScreen> {
  // Copia modificable de los datos de ejemplo.
  // INTEGRACIÓN: aquí se reemplazará por los mazos que entregue Supabase.
  final List<DeckModel> _decks = List.of(sampleDecks);

  /// Abre el formulario y espera su resultado.
  /// - Sin [deck]: crea un mazo nuevo.
  /// - Con [deck]: edita ese mazo.
  Future<void> _openForm({DeckModel? deck}) async {
    final result = await Navigator.of(context).push<DeckModel>(
      MaterialPageRoute<DeckModel>(
        builder: (context) => DeckFormScreen(deck: deck),
      ),
    );

    // result es null si el usuario volvió atrás sin guardar.
    // mounted comprueba que la pantalla siga existiendo tras la espera.
    if (result == null || !mounted) return;

    // INTEGRACIÓN: antes de este setState, llamar al servicio de Supabase
    // (insert si deck == null, update si no).
    setState(() {
      if (deck == null) {
        _decks.add(result);
      } else {
        _decks[_decks.indexOf(deck)] = result;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(deck == null ? 'Mazo creado' : 'Mazo actualizado')),
    );
  }

  void _openDetail(DeckModel deck) {
    // Guardamos la posición ahora: si el mazo se edita desde el detalle,
    // el objeto cambia, pero su lugar en la lista sigue siendo el mismo.
    final index = _decks.indexOf(deck);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => DeckDetailScreen(
          deck: deck,
          // INTEGRACIÓN: llamar también al servicio de actualización aquí.
          onUpdated: (updated) => setState(() => _decks[index] = updated),
        ),
      ),
    );
  }

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
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
            label: const Text('Nuevo mazo'),
          ),
        ),
        const SizedBox(height: 8),
        for (final deck in _decks)
          Card(
            child: ListTile(
              leading: const Icon(Icons.style_outlined, size: 40),
              title: Text(deck.name),
              subtitle: Text(
                '${deck.format} · ${deck.cardCount}/60 cartas · '
                '${deck.cards.length} tipos de carta',
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') _openForm(deck: deck);
                  // INTEGRACIÓN: 'delete' aún no tiene acción.
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'edit', child: Text('Editar')),
                  PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                ],
              ),
              onTap: () => _openDetail(deck),
            ),
          ),
      ],
    );
  }
}

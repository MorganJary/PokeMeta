import 'package:flutter/material.dart';
import 'package:pokemeta/models/card_model.dart';

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({super.key, required this.card});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border),
            tooltip: 'Favorita',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(card.cardNumber),
              ),
              const SizedBox(height: 8),
              Center(
                child: AspectRatio(
                  aspectRatio: 0.72,
                  child: Card(
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 72,
                        semanticLabel: 'Imagen de ${card.name} no disponible',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '${card.expansion} · ${card.rarity}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      card.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    '${card.hp} HP',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 32),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.local_fire_department_outlined),
                      title: const Text('Tipo'),
                      trailing: Text(card.type),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.shield_outlined),
                      title: const Text('Habilidad'),
                      trailing: Text(card.ability),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.bolt_outlined),
                      title: const Text('Coste de retirada'),
                      trailing: Text(
                        List.filled(card.retreatCost, '◯').join(' '),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.flash_on_outlined),
                  title: Text(card.attack),
                  subtitle: Text(card.attackDescription),
                  trailing: Text(card.attackDamage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Debilidad: ${card.weakness} · '
                  'Resistencia: ${card.resistance} · '
                  'Regulación: ${card.regulationMark}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('En el mazo activo'),
                Text('${card.copiesInActiveDeck} copias'),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Agregar al mazo activo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

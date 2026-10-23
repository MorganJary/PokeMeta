import 'package:flutter/material.dart';
import 'package:pokemeta/models/card_model.dart';
import 'package:pokemeta/presentation/screens/cards/card_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFeed = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Buenas tardes, entrenador',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(
          '¿Listo para tu próxima batalla?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.style_outlined),
            title: const Text('Constructor de mazo activo'),
            subtitle: const Text('42 de 60 cartas'),
            trailing: const CircularProgressIndicator(value: 0.7),
          ),
        ),
        const SizedBox(height: 16),
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(
              value: 0,
              icon: Icon(Icons.emoji_events_outlined),
              label: Text('Torneos'),
            ),
            ButtonSegment(
              value: 1,
              icon: Icon(Icons.menu_book_outlined),
              label: Text('Cartas'),
            ),
          ],
          selected: {_selectedFeed},
          onSelectionChanged: (selection) {
            setState(() => _selectedFeed = selection.first);
          },
        ),
        const SizedBox(height: 24),
        if (_selectedFeed == 0) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  'Resultados recientes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Ver todos')),
            ],
          ),
          const _ResultTile(
            number: '01',
            name: 'Victory Road Cup',
            details: 'Toronto · 18 de abril',
            deck: 'Charizard ex',
            players: '128 jugadores',
          ),
          const _ResultTile(
            number: '02',
            name: 'Neon City League',
            details: 'Nueva York · 12 de abril',
            deck: 'Lost Zone Box',
            players: '96 jugadores',
          ),
          const _ResultTile(
            number: '03',
            name: 'Regional Qualifier',
            details: 'Seattle · 5 de abril',
            deck: 'Gardevoir ex',
            players: '214 jugadores',
          ),
        ] else ...[
          Text('Base de cartas', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Buscar cartas',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            children: [
              FilterChip(label: Text('Todas'), onSelected: null),
              FilterChip(label: Text('Pokémon'), onSelected: null),
              FilterChip(label: Text('Entrenador'), onSelected: null),
              FilterChip(label: Text('Energía'), onSelected: null),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 0.78,
            children: [
              for (final card in sampleCards)
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => CardDetailScreen(card: card),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: Icon(Icons.image_outlined, size: 48),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.name,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(card.expansion),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.number,
    required this.name,
    required this.details,
    required this.deck,
    required this.players,
  });

  final String number;
  final String name;
  final String details;
  final String deck;
  final String players;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(number),
        title: Text(name),
        subtitle: Text('$details\n$deck'),
        isThreeLine: true,
        trailing: Text(players),
        onTap: () {},
      ),
    );
  }
}

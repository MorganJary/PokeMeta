import 'package:flutter/material.dart';
import 'package:pokemeta/presentation/screens/login/login_screen.dart';
import 'package:pokemeta/presentation/screens/profile/trainer_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(child: Icon(Icons.person_outline)),
          title: Text(
            'Perfil de entrenador',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: Text(
            'Alex Morgan\nUltra League · #1.284',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Editar perfil',
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ProfileStat(value: '3', label: 'Mazos guardados'),
                _ProfileStat(value: '24', label: 'Victorias'),
                _ProfileStat(value: '68%', label: 'Porcentaje'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Cuenta', style: Theme.of(context).textTheme.titleLarge),
        ListTile(
          leading: Icon(Icons.person_outline),
          title: Text('Datos del entrenador'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const TrainerDetailsScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Cerrar sesión'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});

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

import 'package:flutter/material.dart';
import 'package:pokemeta/presentation/screens/login/login_screen.dart';

void main() {
  runApp(const PokeMetaApp());
}

class PokeMetaApp extends StatelessWidget {
  const PokeMetaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeMeta',
      theme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}

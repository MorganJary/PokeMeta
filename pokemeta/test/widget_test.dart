import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemeta/main.dart';

void main() {
  testWidgets('Login opens the app and bottom navigation changes screens', (
    tester,
  ) async {
    await tester.pumpWidget(const PokeMetaApp());

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Buenas tardes, entrenador'), findsOneWidget);

    expect(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Cartas'),
      ),
      findsNothing,
    );
    await tester.tap(find.text('Cartas'));
    await tester.pumpAndSettle();
    expect(find.text('Base de cartas'), findsOneWidget);

    final charizardCard = find.text('Charizard ex');
    await tester.drag(find.byType(ListView).first, const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(charizardCard);
    await tester.pumpAndSettle();
    expect(find.text('Paldean Fates · Special Rare'), findsOneWidget);
    expect(find.text('Infernal Reign'), findsOneWidget);
    expect(find.text('Burning Darkness'), findsOneWidget);
    expect(find.text('330 HP'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    final decksDestination = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Mazos'),
    );
    await tester.tap(decksDestination);
    await tester.pumpAndSettle();
    expect(find.text('Mis mazos'), findsOneWidget);

    await tester.tap(find.text('Infernal Reign'));
    await tester.pumpAndSettle();
    expect(find.text('Contenido del mazo'), findsOneWidget);
    expect(find.text('Charizard ex'), findsOneWidget);
    expect(find.text('Fuego · Paldean Fates'), findsOneWidget);
    expect(find.text('Greninja ex'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    final profileDestination = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Perfil'),
    );
    await tester.tap(profileDestination);
    await tester.pumpAndSettle();
    expect(find.text('Perfil de entrenador'), findsOneWidget);
    expect(find.text('Configuración'), findsNothing);
    expect(find.text('Notificaciones'), findsNothing);

    await tester.tap(find.text('Datos del entrenador'));
    await tester.pumpAndSettle();
    expect(find.text('Mazo más utilizado'), findsOneWidget);
    expect(find.text('Infernal Reign · Estándar'), findsOneWidget);
    expect(find.text('Carta favorita'), findsOneWidget);
    expect(find.text('Charizard ex · Fuego'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';

/// Resumen del mazo que el usuario está construyendo.
///
/// Recibe cuántas cartas hay y el máximo; el progreso se CALCULA aquí,
/// así nunca queda inconsistente con el texto.
class ActiveDeckBanner extends StatelessWidget {
  const ActiveDeckBanner({
    super.key,
    required this.currentCount,
    this.maxCount = 60,
  });

  final int currentCount;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.style_outlined),
        title: const Text('Constructor de mazo activo'),
        subtitle: Text('$currentCount de $maxCount cartas'),
        trailing: CircularProgressIndicator(value: currentCount / maxCount),
      ),
    );
  }
}

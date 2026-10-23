# Contexto de desarrollo — PokeMeta

## Propósito

Aplicación Flutter para jugadores competitivos de Pokémon TCG. El README de la raíz, [`README.md`](./README.md), describe el objetivo del producto y nueve requisitos de la asignatura. Este archivo deja constancia del estado revisado y del alcance para retomar el trabajo en otra sesión.

## Alcance acordado para la sesión actual

- Trabajar únicamente en el frontend y revisar qué requisitos del README están cubiertos por la implementación actual.
- No implementar animaciones ni widgets reutilizables propios de los requisitos 4 y 8.
- No implementar autenticación, APIs, Supabase, persistencia, estado global ni otras partes fuera del frontend.
- Las pantallas pueden usar los widgets estándar de Flutter; la exclusión de “widgets” se refiere a no desarrollar los componentes reutilizables solicitados por el requisito 8.
- La interfaz existente es una estructura funcional básica con contenido de ejemplo; no representa una integración de datos ni una implementación final del diseño de referencia.

## Estructura actual

El proyecto Flutter está en `pokemeta/`.

```text
pokemeta/lib/
├── main.dart
├── models/
│   ├── card_model.dart
│   └── deck_model.dart
└── presentation/screens/
    ├── login/login_screen.dart
    ├── main_navigation_screen.dart
    ├── home/home_screen.dart
    ├── cards/
    │   └── card_detail_screen.dart
    ├── decks/
    │   ├── decks_screen.dart
    │   └── deck_detail_screen.dart
    └── profile/
        ├── profile_screen.dart
        └── trainer_details_screen.dart
```

- `main.dart`: inicia `PokeMetaApp` y muestra `LoginScreen`.
- `login/login_screen.dart`: campos de correo y contraseña, opción “Recordarme” y botones de acceso/registro. El acceso navega a la app sin autenticar ni validar credenciales; registro y recuperación no tienen acción implementada.
- `main_navigation_screen.dart`: navegación inferior entre Inicio, Mazos y Perfil. Conserva las pestañas con `IndexedStack`; Cartas ya no es una pestaña.
- `home/home_screen.dart`: resumen y selector entre torneos/cartas. La sección Cartas contiene búsqueda, filtros sin acción y la grilla seleccionable del catálogo de ejemplo.
- `cards/card_detail_screen.dart`: pantalla de detalle que recibe un `CardModel` por constructor; muestra información de ejemplo, espacio de imagen y acciones visuales sin integración.
- `decks/decks_screen.dart`: lista de mazos estáticos seleccionables.
- `decks/deck_detail_screen.dart`: detalle del mazo con formato, resumen y cartas; cada entrada muestra nombre, tipo elemental, expansión y cantidad.
- `profile/profile_screen.dart`: perfil de ejemplo; “Datos del entrenador” abre sus estadísticas y “Cerrar sesión” vuelve a la pantalla de acceso y limpia la pila de navegación. No hay autenticación real.
- `profile/trainer_details_screen.dart`: muestra mazo más utilizado y carta favorita como ejemplos enlazados a sus respectivas pantallas de detalle.
- `models/card_model.dart`: modelo y catálogo local de ejemplo.
- `models/deck_model.dart`: modelo del mazo y contenido local estático de muestra.

Las pantallas usan el tema estándar de Material (`ThemeData()`); no se configuró una paleta ni se integraron recursos gráficos. `pubspec.yaml` aún no declara Supabase, Provider ni cliente HTTP.

## Revisión de los requisitos del README

| # | Requisito | Estado observado |
|---|---|---|
| 1 | Login y autenticación Supabase | **No implementado.** Hay una pantalla de acceso, pero no hay autenticación, registro ni cierre de sesión conectados a Supabase. |
| 2 | Consumo de API con `FutureBuilder` | **No implementado.** Torneos, cartas y estadísticas son datos estáticos/de ejemplo; no hay llamadas a APIs ni `FutureBuilder`. |
| 3 | Navegación a detalle pasando parámetros | **Parcial, actualizado.** La sección Cartas de Inicio abre detalles pasando `CardModel`; la lista de Mazos abre detalles pasando `DeckModel`. Falta la pantalla de detalle de torneo y el paso de su modelo. |
| 4 | Animaciones `Hero` e implícitas | **Pendiente y fuera del alcance acordado.** No se implementaron y no deben añadirse en esta etapa. |
| 5 | CRUD de mazos con Supabase y RLS | **No implementado.** El listado es estático; no hay persistencia, CRUD ni políticas configuradas. |
| 6 | Formulario de mazos con validación | **No implementado.** El formulario de acceso no es el formulario de creación/edición de mazos requerido; el botón “Nuevo mazo” no tiene acción. |
| 7 | Estado global con Provider | **No implementado.** No hay `Provider`, `ChangeNotifier` ni estado compartido del mazo. |
| 8 | Widgets propios reutilizables | **Pendiente y fuera del alcance acordado.** No se creó el conjunto de componentes reutilizables requerido en `lib/widgets/`. |
| 9 | Flujo colaborativo en GitHub | **No evaluado en esta revisión.** Es un requisito de historial/colaboración, no de interfaz. |

**Conclusión:** el frontend actual cubre la estructura inicial de acceso, contenido y navegación, pero no se puede afirmar que el proyecto cumpla los nueve requisitos del README. Los requisitos de backend/datos/estado están pendientes; animaciones y widgets reutilizables se excluyeron expresamente de la etapa actual.

## Verificación registrada

`flutter analyze` no reporta problemas y `flutter test` pasa la prueba que recorre el acceso, la navegación por pestañas, los detalles de carta y mazo, los datos del entrenador y el cierre de sesión hacia el acceso. Esta verificación confirma la navegación frontend, no el cumplimiento de los requisitos de integración.

## Punto de continuación

Antes de continuar, confirmar con el usuario el alcance de la próxima etapa. Mantener separados:

1. **Frontend:** completar y refinar pantallas, estados vacíos y navegación de detalle, respetando cualquier exclusión vigente sobre animaciones y componentes reutilizables.
2. **Integraciones y requisitos de la asignatura:** autenticación Supabase, APIs, modelos, CRUD/RLS, formularios validados y estado global; no darlos por implementados por la presencia de controles de ejemplo.
3. **Requisitos explícitamente diferidos:** resolver con el usuario cuándo abordar animaciones y widgets reutilizables.

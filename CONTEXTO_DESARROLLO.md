# Contexto de desarrollo — PokeMeta

## Propósito

Aplicación Flutter para jugadores competitivos de Pokémon TCG. El README de la raíz, [`README.md`](./README.md), describe el objetivo del producto y los nueve requisitos de la asignatura. Este archivo deja constancia del estado del proyecto, del reparto de trabajo y de los puntos donde el frontend espera la integración del backend, para retomar el trabajo en otra sesión.

## Reparto del trabajo

- **Frontend (Flutter):** pantallas, navegación, paso de parámetros, animaciones, formulario validado, widgets reutilizables y estado global con Provider.
- **Backend y APIs (compañero):** autenticación con Supabase, tabla de mazos con RLS, consumo de las APIs externas y los servicios que entregan los datos.

El frontend usa hoy datos de ejemplo locales. Cada punto donde deben conectarse los datos reales está marcado en el código con comentarios `INTEGRACIÓN`.

## Estructura actual

El proyecto Flutter está en `pokemeta/`.

```text
pokemeta/lib/
├── main.dart
├── models/
│   ├── card_model.dart
│   ├── deck_model.dart
│   └── tournament_model.dart
├── widgets/
│   ├── active_deck_banner.dart
│   ├── card_image.dart
│   ├── custom_stat_row.dart
│   ├── pokemon_card_tile.dart
│   ├── stat_badge_widget.dart
│   └── tournament_row_card.dart
└── presentation/screens/
    ├── login/login_screen.dart
    ├── main_navigation_screen.dart
    ├── home/home_screen.dart
    ├── cards/card_detail_screen.dart
    ├── decks/
    │   ├── decks_screen.dart
    │   ├── deck_detail_screen.dart
    │   └── deck_form_screen.dart
    ├── tournaments/tournament_detail_screen.dart
    └── profile/
        ├── profile_screen.dart
        └── trainer_details_screen.dart
```

### Qué hace cada archivo

- `main.dart`: inicia `PokeMetaApp` y muestra `LoginScreen`. Usa el tema estándar de Material (`ThemeData()`); aún no hay paleta propia.
- `login/login_screen.dart`: campos de correo y contraseña, “Recordarme” y botones de acceso/registro. El acceso navega a la app **sin autenticar ni validar**; registro y recuperación no tienen acción.
- `main_navigation_screen.dart`: navegación inferior entre Inicio, Mazos y Perfil. Conserva las pestañas con `IndexedStack`.
- `home/home_screen.dart`: resumen y selector Torneos/Cartas. Torneos lista `sampleTournaments` y abre `TournamentDetailScreen`. Cartas tiene búsqueda y filtros sin acción, y una grilla de `PokemonCardTile` que abre `CardDetailScreen`.
- `cards/card_detail_screen.dart`: detalle de carta (recibe `CardModel` por constructor). Es `StatefulWidget`: guarda si la carta es favorita **solo en memoria** y la anima con `AnimatedContainer` y `AnimatedScale`. El botón “Agregar al mazo activo” no tiene acción.
- `decks/decks_screen.dart`: lista de mazos (`_decks`, copia de `sampleDecks`). “Nuevo mazo” y “Editar” abren `DeckFormScreen` y reciben el resultado con `await Navigator.push`. “Eliminar” no tiene acción.
- `decks/deck_form_screen.dart`: formulario de crear/editar mazo con `Form`, `TextFormField` y `validator`. Devuelve un `DeckModel` con `Navigator.pop`.
- `decks/deck_detail_screen.dart`: detalle del mazo, con opción de editar (botón en la barra y botón con texto). Avisa a la lista con el callback `onUpdated`. Cada carta abre su detalle.
- `tournaments/tournament_detail_screen.dart`: detalle de torneo (recibe `TournamentModel` por constructor). La sección “Clasificación” es un estado vacío a la espera de datos.
- `profile/profile_screen.dart`: perfil de ejemplo. “Datos del entrenador” abre sus estadísticas y “Cerrar sesión” vuelve al acceso limpiando la pila de navegación. No hay autenticación real.
- `profile/trainer_details_screen.dart`: mazo más utilizado y carta favorita como ejemplos enlazados a sus detalles.
- `widgets/`: componentes reutilizables (requisito 8). `CardImage` incluye el `Hero` de la carta.

## Estado de los requisitos del README

| # | Requisito | Estado | Responsable |
|---|---|---|---|
| 1 | Login y autenticación Supabase | **Pendiente.** Hay pantalla de acceso, sin autenticación real. | Backend |
| 2 | Consumo de API con `FutureBuilder` | **Pendiente.** Todos los datos son de ejemplo. | Backend (servicios) + Frontend (`FutureBuilder`, carga y error) |
| 3 | Navegación a detalle pasando parámetros | **Cubierto.** Carta (desde grilla y desde mazo), mazo y torneo reciben su modelo por el constructor. | Frontend |
| 4 | Animaciones `Hero` e implícitas | **Cubierto.** `Hero` en la imagen de carta (grilla, mazo y detalle) y `AnimatedScale` + `AnimatedContainer` en la estrella de favorita. | Frontend |
| 5 | CRUD de mazos con Supabase y RLS | **Pendiente.** La lista es local y se pierde al reiniciar. | Backend |
| 6 | Formulario con validación | **Cubierto en el frontend** (`DeckFormScreen`). Falta conectar con la persistencia. | Frontend |
| 7 | Estado global con Provider | **Pendiente.** No hay `Provider` ni `ChangeNotifier`. | Frontend |
| 8 | Widgets propios reutilizables | **Cubierto.** Seis widgets en `lib/widgets/`. | Frontend |
| 9 | Flujo colaborativo en GitHub | **No evaluado.** Es de historial y colaboración. | Todos |

## Guía de integración para backend

### 1. Contratos de los modelos

Los modelos están en `lib/models/`. Todos son inmutables (campos `final`, constructor `const`). Falta agregarles `fromJson` (y `toJson` en los que se envían) cuando se conozca la forma de las respuestas.

**`TournamentModel`**

| Campo | Tipo | Notas |
|---|---|---|
| `name` | `String` | |
| `city` | `String` | |
| `date` | `String` | Hoy texto ya formateado (“18 de abril”). Si la API entrega fecha, convertir antes de crear el modelo o cambiar el tipo a `DateTime` y formatear en los widgets. |
| `winningDeck` | `String` | |
| `players` | `int` | |

**`CardModel`**: `name`, `expansion`, `rarity`, `cardNumber`, `hp` (`int`), `type`, `ability`, `attack`, `attackDamage`, `attackDescription`, `retreatCost` (`int`), `weakness`, `resistance`, `regulationMark` (todos `String` salvo los indicados) y `copiesInActiveDeck` (`int`, valor temporal, ver abajo).

- `cardNumber` se usa como etiqueta del `Hero`, así que **debe ser único** por carta.
- No existe aún un campo de imagen. Hay que agregar `imageUrl` a `CardModel` y mostrarla en `widgets/card_image.dart`, que es el único lugar donde se dibuja la imagen (hoy muestra un ícono de reemplazo).
- `copiesInActiveDeck` es un valor de relleno. Se eliminará del modelo cuando se implemente el Provider, porque pertenece al estado del mazo y no a la carta.

**`DeckModel`**

| Campo | Tipo | Notas |
|---|---|---|
| `name` | `String` | Validado en el formulario: 3 a 30 caracteres. |
| `format` | `String` | Hoy solo `Estándar` o `Expandido`. |
| `description` | `String` | Validada en el formulario: 10 a 200 caracteres. |
| `cards` | `List<DeckCardEntry>` | Cada entrada es una carta (`CardModel`) y una cantidad (`count`). |

`cardCount` es un getter calculado (suma de cantidades). No se guarda.

Propuesta de tabla (a confirmar con el backend): `decks` con `id`, `user_id` (por defecto `auth.uid()`), `name`, `format`, `description`, `created_at`, y una tabla de relación (por ejemplo `deck_cards` con `deck_id`, `card_id` y `count`) o una columna `jsonb` para las cartas. RLS: cada usuario solo puede leer, crear, actualizar y eliminar filas con su `user_id`. Conviene reflejar en la base las mismas reglas de longitud y los formatos válidos que valida el formulario.

### 2. Datos de ejemplo a reemplazar

| Dato de ejemplo | Dónde se usa |
|---|---|
| `sampleCards` (`card_model.dart`) | Grilla de cartas en `home_screen.dart` |
| `sampleDecks` (`deck_model.dart`) | `_decks` en `decks_screen.dart` |
| `sampleTournaments` (`tournament_model.dart`) | Lista de torneos en `home_screen.dart` |

Al conectar los datos reales habrá que agregar estados de **carga**, **error** y **lista vacía** en esas pantallas. Se recomienda que los servicios (`lib/services/`) devuelvan `Future<List<Modelo>>` para usarlos directamente en un `FutureBuilder`.

### 3. Puntos de conexión en el código

Buscar los comentarios `INTEGRACIÓN`:

- `decks_screen.dart`, `_decks`: reemplazar la lista local por los mazos del usuario.
- `decks_screen.dart`, `_openForm`: tras el `await` del formulario, llamar al servicio de crear (si `deck == null`) o actualizar, antes del `setState`.
- `decks_screen.dart`, `_openDetail`: el callback `onUpdated` se dispara cuando se edita desde el detalle; también debe llamar al servicio de actualizar.
- `decks_screen.dart`, menú ⋮: “Eliminar” no tiene acción (falta confirmación y borrado).
- `login_screen.dart`: reemplazar la navegación directa por `signIn` y `signUp` de `supabase_flutter`, validando credenciales y mostrando errores.
- `profile_screen.dart`: “Cerrar sesión” debe llamar a `signOut`.
- `main.dart`: inicializar Supabase antes de `runApp`.

### 4. Dependencias pendientes en `pubspec.yaml`

Hoy solo están `flutter` y `cupertino_icons`. Faltan `supabase_flutter`, `http` y `provider`. No guardar claves ni URLs de Supabase en el repositorio; usar `--dart-define` o un archivo de configuración ignorado por Git.

### 5. Datos que hoy solo viven en memoria

- Favoritas: el estado vive en `CardDetailScreen` y se pierde al salir de la pantalla.
- Mazo activo: `ActiveDeckBanner` recibe un valor fijo (`42` de `60`) desde `home_screen.dart`. Se alimentará del Provider.
- Datos del entrenador y torneos de ejemplo del perfil.
- Clasificación del torneo: pantalla de detalle con estado vacío.

## Verificación registrada

El desarrollador ejecutó la app con `flutter run` (Chrome) y comprobó manualmente la navegación, las animaciones y el formulario. **Falta registrar** el resultado de `flutter analyze` y `flutter test` tras los últimos cambios. La prueba existente recorre el acceso, las pestañas, los detalles y el cierre de sesión, y puede necesitar ajustes por las pantallas nuevas.

## Punto de continuación

1. **Frontend:** implementar el Provider (`ActiveDeckProvider`) y quitar `copiesInActiveDeck` del modelo; definir tema y paleta propios; implementar “Eliminar” mazo; completar búsqueda, filtros y “Agregar al mazo activo”.
2. **Backend:** autenticación, tabla de mazos con RLS, servicios de API y `fromJson` de los modelos.
3. **Coordinación:** acordar los campos de los modelos antes de conectar, y quién escribe cada `FutureBuilder`.

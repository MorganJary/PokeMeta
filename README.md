# 🃏 PokéMeta Deck & Tracker

Aplicación móvil desarrollada en **Flutter** para jugadores competitivos de Pokémon Trading Card Game (TCG). Permite explorar resultados de torneos (esports/deporte mental), consultar el catálogo oficial de cartas y construir/gestionar mazos personalizados en la nube.

Proyecto Integrador desarrollado para la asignatura **IIP323W — Tecnologías y Aplicaciones Web y Móviles** (Universidad del Desarrollo, 2026).

---

## 📋 Cumplimiento de Requisitos de la Asignatura

Este repositorio ha sido estructurado para cumplir con los 9 criterios de evaluación del curso:

1. **Login con Supabase:** Autenticación completa de usuarios (`SignUp`, `SignIn`, `SignOut`) gestionada mediante `supabase_flutter`.
2. **Datos de la API (`FutureBuilder`):** Consumo asíncrono de APIs REST para listar torneos competitivos recientes, posiciones (*standings*) y el catálogo de cartas de Pokémon TCG.
3. **Navegación con paso de parámetros:** Selección de cartas o torneos que navegan hacia una vista de detalle (`CardDetailScreen` / `TournamentDetailScreen`), pasando el modelo de datos directamente por el constructor del widget.
4. **Animaciones:**
   * **Hero:** Transición fluida de la imagen de la carta desde la grilla principal hasta la pantalla de inspección detallada.
   * **Animación Implícita:** Uso de `AnimatedScale` y `AnimatedContainer` para dar *feedback* visual interactivo al agregar cartas al mazo o marcar favoritos.
5. **Tabla en Supabase con RLS (CRUD):** Almacenamiento de los mazos de cada jugador en PostgreSQL (Supabase) con políticas de *Row Level Security* (RLS) activas para que cada usuario solo pueda crear, leer, actualizar y eliminar sus propios registros
6. **Formulario con validación:** Implementación de `Form` y `TextFormField` con reglas de validación (`validator`) para la creación y edición de mazos (verificando longitud de nombre, formato de juego y descripción)
7. **Estado Global con Provider:** Uso de `ChangeNotifier` (`ActiveDeckProvider`) compartido entre múltiples pantallas para gestionar en tiempo real el contador y listado de cartas del mazo en construcción
8. **Widgets propios reutilizables:** Componentes modulares extraídos en sus propios archivos dentro de `lib/widgets/` (ej. `PokemonCardTile`, `StatBadgeWidget`, `TournamentRowCard`)
9. **Flujo colaborativo en GitHub:** Historial de commits distribuido entre todos los integrantes del equipo según sus roles asignados.

---

## 🛠️ Stack Tecnológico y Dependencias

* **Framework:** Flutter & Dart
* **Backend & Auth:** [Supabase](https://supabase.com/) (`supabase_flutter`)
* **Gestión de Estado:** `provider` (`ChangeNotifier`)
* **Cliente HTTP:** `http`
* **APIs Externas:**
  * [Limitless TCG API](https://docs.limitlesstcg.com/) / [TopDeck.gg API](https://topdeck.gg/docs/tournaments-v2) — Datos de torneos competitivos, *standings* y *decklists*.
  * [Pokémon TCG API](https://pokemontcg.io/) / [TCGdex API](https://tcgdex.dev/) — Imágenes de cartas en alta resolución, estadísticas y expansiones.

---

## 📂 Estructura del Proyecto (Propuesta)

```text
lib/
├── main.dart                  # Punto de entrada, inicialización de Supabase y MultiProvider
├── models/                    # Modelos de datos (CardModel, DeckModel, TournamentModel)
├── providers/                 # ChangeNotifiers para estado global (ActiveDeckProvider)
├── services/                  # Lógica de consumo de API REST y cliente de Supabase
├── screens/                   # Pantallas de la aplicación
│   ├── auth_screen.dart       # Login y Registro con Supabase
│   ├── home_screen.dart       # Explorador de Torneos y Cartas (FutureBuilder)
│   ├── card_detail_screen.dart# Vista de detalle (Constructor + Hero + Animación Implícita)
│   └── my_decks_screen.dart   # CRUD de mazos en Supabase y Formulario validado
└── widgets/                   # Widgets propios reutilizables en archivos separados
    ├── pokemon_card_tile.dart
    ├── custom_stat_row.dart
    └── active_deck_banner.dart

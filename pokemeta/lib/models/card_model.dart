class CardModel {
  const CardModel({
    required this.name,
    required this.expansion,
    required this.rarity,
    required this.cardNumber,
    required this.hp,
    required this.type,
    required this.ability,
    required this.attack,
    required this.attackDamage,
    required this.attackDescription,
    required this.retreatCost,
    required this.weakness,
    required this.resistance,
    required this.regulationMark,
    this.copiesInActiveDeck = 2,
  });

  final String name;
  final String expansion;
  final String rarity;
  final String cardNumber;
  final int hp;
  final String type;
  final String ability;
  final String attack;
  final String attackDamage;
  final String attackDescription;
  final int retreatCost;
  final String weakness;
  final String resistance;
  final String regulationMark;
  final int copiesInActiveDeck;
}

const sampleCards = [
  CardModel(
    name: 'Charizard ex',
    expansion: 'Paldean Fates',
    rarity: 'Special Rare',
    cardNumber: 'SVP - 056/091',
    hp: 330,
    type: 'Fuego',
    ability: 'Infernal Reign',
    attack: 'Burning Darkness',
    attackDamage: '180+',
    attackDescription:
        'Este ataque hace 30 puntos de daño más por cada carta de Premio '
        'que haya tomado tu rival.',
    retreatCost: 3,
    weakness: 'Fuego ×2',
    resistance: '—',
    regulationMark: 'F',
  ),
  CardModel(
    name: 'Greninja ex',
    expansion: 'Twilight Masquerade',
    rarity: 'Special Illustration Rare',
    cardNumber: 'TWM - 214/167',
    hp: 300,
    type: 'Agua',
    ability: 'Torrential Veil',
    attack: 'Mirage Barrage',
    attackDamage: '120',
    attackDescription: 'Inflige daño a dos Pokémon del rival.',
    retreatCost: 1,
    weakness: 'Rayo ×2',
    resistance: '—',
    regulationMark: 'H',
  ),
  CardModel(
    name: 'Mew ex',
    expansion: 'Paldean Fates',
    rarity: 'Special Illustration Rare',
    cardNumber: 'PAF - 232/091',
    hp: 180,
    type: 'Psíquico',
    ability: 'Restart',
    attack: 'Genome Hacking',
    attackDamage: '—',
    attackDescription: 'Usa uno de los ataques del Pokémon Activo rival.',
    retreatCost: 1,
    weakness: 'Oscuridad ×2',
    resistance: 'Lucha −30',
    regulationMark: 'G',
  ),
  CardModel(
    name: 'Frigibax',
    expansion: 'Paldea Evolved',
    rarity: 'Illustration Rare',
    cardNumber: 'PAL - 208/193',
    hp: 60,
    type: 'Agua',
    ability: 'Ninguna',
    attack: 'Placaje',
    attackDamage: '30',
    attackDescription: 'Un ataque sencillo de un Pokémon básico.',
    retreatCost: 1,
    weakness: 'Metal ×2',
    resistance: '—',
    regulationMark: 'G',
  ),
];

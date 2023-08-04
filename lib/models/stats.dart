// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Stats {
  int health;
  int armour;
  int weaken;
  int fragility;
  int poison;
  int strength;
  int dexterity;
  int intelligence;
  Stats({
    required this.health,
    required this.armour,
    required this.weaken,
    required this.fragility,
    required this.poison,
    required this.strength,
    required this.dexterity,
    required this.intelligence,
  });

  static Stats empty() {
    return Stats(
        health: 30,
        armour: 0,
        weaken: 0,
        fragility: 0,
        poison: 0,
        strength: 0,
        dexterity: 0,
        intelligence: 0);
  }

  void toEmpty() {
    health = 30;
    armour = 0;
    weaken = 0;
    fragility = 0;
    poison = 0;
    strength = 0;
    dexterity = 0;
    intelligence = 0;
  }

  Stats copyWith({
    int? health,
    int? armour,
    int? weaken,
    int? fragility,
    int? poison,
    int? strength,
    int? dexterity,
    int? intelligence,
  }) {
    return Stats(
      health: health ?? this.health,
      armour: armour ?? this.armour,
      weaken: weaken ?? this.weaken,
      fragility: fragility ?? this.fragility,
      poison: poison ?? this.poison,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      intelligence: intelligence ?? this.intelligence,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'health': health,
      'armour': armour,
      'weaken': weaken,
      'fragility': fragility,
      'poison': poison,
      'strength': strength,
      'dexterity': dexterity,
      'intelligence': intelligence,
    };
  }

  factory Stats.fromMap(Map<String, dynamic> map) {
    return Stats(
      health: map['health'] as int,
      armour: map['armour'] as int,
      weaken: map['weaken'] as int,
      fragility: map['fragility'] as int,
      poison: map['poison'] as int,
      strength: map['strength'] as int,
      dexterity: map['dexterity'] as int,
      intelligence: map['intelligence'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Stats.fromJson(String source) =>
      Stats.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Stats(health: $health, armour: $armour, weaken: $weaken, fragility: $fragility, poison: $poison, strength: $strength, dexterity: $dexterity, intelligence: $intelligence)';
  }

  @override
  bool operator ==(covariant Stats other) {
    if (identical(this, other)) return true;

    return other.health == health &&
        other.armour == armour &&
        other.weaken == weaken &&
        other.fragility == fragility &&
        other.poison == poison &&
        other.strength == strength &&
        other.dexterity == dexterity &&
        other.intelligence == intelligence;
  }

  @override
  int get hashCode {
    return health.hashCode ^
        armour.hashCode ^
        weaken.hashCode ^
        fragility.hashCode ^
        poison.hashCode ^
        strength.hashCode ^
        dexterity.hashCode ^
        intelligence.hashCode;
  }
}

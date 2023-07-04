// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:the_test_naruto_arena/models/enum_serializer.dart';

import 'effect.dart';
import 'enums.dart';

class Skill {
  int id;
  String name;
  String img;
  List<Energy> requiredEnergy;
  int cooldownValue;
  int cooldown;
  List<Effect> effects;
  Skill({
    required this.id,
    required this.name,
    required this.img,
    required this.requiredEnergy,
    required this.cooldownValue,
    required this.cooldown,
    required this.effects,
  });
  static Skill getEmpty() {
    return Skill(
      id: 0,
      name: '',
      img: '',
      requiredEnergy: [],
      cooldownValue: 0,
      cooldown: 0,
      effects: [],
    );
  }

  Skill copyWith({
    int? id,
    String? name,
    String? img,
    List<Energy>? requiredEnergy,
    int? cooldownValue,
    int? cooldown,
    List<Effect>? effects,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      requiredEnergy: requiredEnergy ?? this.requiredEnergy,
      cooldownValue: cooldownValue ?? this.cooldownValue,
      cooldown: cooldown ?? this.cooldown,
      effects: effects ?? this.effects,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'requiredEnergy': requiredEnergy.map((x) => EnumSerializer.energyToString(x)).toList(),
      'cooldownValue': cooldownValue,
      'cooldown': cooldown,
      'effects': effects.map((x) => x.toMap()).toList(),
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'] as int,
      name: map['name'] as String,
      img: map['img'] as String,
      requiredEnergy: List<Energy>.from((map['requiredEnergy'] as List<dynamic>).map<Energy>((x) => EnumSerializer.energyFromString(x.toString()))),
      cooldownValue: map['cooldownValue'] as int,
      cooldown: map['cooldown'] as int,
      effects: List<Effect>.from((map['effects'] as List<dynamic>).map<Effect>((x) => Effect.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) => Skill.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, img: $img, requiredEnergy: $requiredEnergy, cooldownValue: $cooldownValue, cooldown: $cooldown, effects: $effects)';
  }

  @override
  bool operator ==(covariant Skill other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.img == img &&
      listEquals(other.requiredEnergy, requiredEnergy) &&
      other.cooldownValue == cooldownValue &&
      other.cooldown == cooldown &&
      listEquals(other.effects, effects);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      img.hashCode ^
      requiredEnergy.hashCode ^
      cooldownValue.hashCode ^
      cooldown.hashCode ^
      effects.hashCode;
  }
}

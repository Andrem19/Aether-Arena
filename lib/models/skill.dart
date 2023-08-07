// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:the_test_naruto_arena/models/enum_serializer.dart';

import 'effect.dart';
import 'enums.dart';

class Skill {
  int id;
  String name;
  String description;
  String img;
  Map<Energy, int> requiredEnergy;
  Target target;
  int cooldownValue;
  int cooldown;
  List<Effect> effects;
  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.img,
    required this.requiredEnergy,
    required this.target,
    required this.cooldownValue,
    required this.cooldown,
    required this.effects,
  });
  static Skill getEmpty() {
    return Skill(
      id: 0,
      name: '',
      description: '',
      img: '',
      requiredEnergy: {},
      target: Target.None,
      cooldownValue: 0,
      cooldown: 0,
      effects: [],
    );
  }

  Skill copyWith({
    int? id,
    String? name,
    String? description,
    String? img,
    Map<Energy, int>? requiredEnergy,
    Target? target,
    int? effect_id,
    int? cooldownValue,
    int? cooldown,
    List<Effect>? effects,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      img: img ?? this.img,
      requiredEnergy: requiredEnergy ?? this.requiredEnergy,
      target: target ?? this.target,
      cooldownValue: cooldownValue ?? this.cooldownValue,
      cooldown: cooldown ?? this.cooldown,
      effects: effects ?? this.effects,
    );
  }

  Map<String, dynamic> toMap() {
  Map<String, dynamic> requiredEnergyAsString = requiredEnergy.map(
      (key, value) => MapEntry(EnumSerializer.energyToString(key), value));
  return <String, dynamic>{
    'id': id,
    'name': name,
    'description': description,
    'img': img,
    'requiredEnergy': requiredEnergyAsString,
    'target': EnumSerializer.targetToString(target),
    'cooldownValue': cooldownValue,
    'cooldown': cooldown,
    'effects': effects.map((x) => x.toMap()).toList(),
  };
}

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      img: map['img'] as String,
      requiredEnergy: Map<Energy, int>.from(
          (map['requiredEnergy'] as Map<dynamic, dynamic>).map(
        (key, value) =>
            MapEntry(EnumSerializer.energyFromString(key), value as int),
      )),
      target: EnumSerializer.targetFromString(map['target']),
      cooldownValue: map['cooldownValue'] as int,
      cooldown: map['cooldown'] as int,
      effects: List<Effect>.from(
        (map['effects'] as List<dynamic>).map<Effect>(
          (x) => Effect.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) =>
      Skill.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, description: $description, img: $img, requiredEnergy: $requiredEnergy, cooldownValue: $cooldownValue, cooldown: $cooldown, effects: $effects)';
  }

  @override
  bool operator ==(covariant Skill other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.img == img &&
        mapEquals(other.requiredEnergy, requiredEnergy) &&
        other.target == target &&
        other.cooldownValue == cooldownValue &&
        other.cooldown == cooldown &&
        listEquals(other.effects, effects);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        img.hashCode ^
        requiredEnergy.hashCode ^
        target.hashCode ^
        cooldownValue.hashCode ^
        cooldown.hashCode ^
        effects.hashCode;
  }
}

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
  bool replaceable;
  List<int> replace;
  Map<Energy, int> requiredEnergy;
  int cooldownValue;
  int cooldown;
  List<Effect> effects;
  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.img,
    required this.replaceable,
    required this.replace,
    required this.requiredEnergy,
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
      replaceable: false,
      replace: [],
      requiredEnergy: {},
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
    bool? replaceable,
    List<int>? replace,
    Map<Energy, int>? requiredEnergy,
    int? cooldownValue,
    int? cooldown,
    List<Effect>? effects,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      img: img ?? this.img,
      replaceable: replaceable ?? this.replaceable,
      replace: replace ?? this.replace,
      requiredEnergy: requiredEnergy ?? this.requiredEnergy,
      cooldownValue: cooldownValue ?? this.cooldownValue,
      cooldown: cooldown ?? this.cooldown,
      effects: effects ?? this.effects,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, int> requiredEnergyAsString = requiredEnergy.map(
    (key, value) => MapEntry(EnumSerializer.energyToString(key), value)
  );
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'img': img,
      'replaceable': replaceable,
      'replace': replace,
      'requiredEnergy': requiredEnergyAsString,
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
      replaceable: map['replaceable'] as bool,
      replace: List<int>.from((map['replace'] as List<dynamic>)),
      requiredEnergy: Map<Energy, int>.from((map['requiredEnergy'] as Map<dynamic, dynamic>).map(
      (key, value) => MapEntry(EnumSerializer.energyFromString(key), value as int),
    )),
      cooldownValue: map['cooldownValue'] as int,
      cooldown: map['cooldown'] as int,
      effects: List<Effect>.from((map['effects'] as List<dynamic>).map<Effect>((x) => Effect.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) =>
      Skill.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Skill(id: $id, name: $name, description: $description, img: $img, replaceable: $replaceable, replace: $replace, requiredEnergy: $requiredEnergy, cooldownValue: $cooldownValue, cooldown: $cooldown, effects: $effects)';
  }

  @override
  bool operator ==(covariant Skill other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.img == img &&
      other.replaceable == replaceable &&
      listEquals(other.replace, replace) &&
      mapEquals(other.requiredEnergy, requiredEnergy) &&
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
      replaceable.hashCode ^
      replace.hashCode ^
      requiredEnergy.hashCode ^
      cooldownValue.hashCode ^
      cooldown.hashCode ^
      effects.hashCode;
  }
}

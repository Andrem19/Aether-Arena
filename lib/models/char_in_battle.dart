// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:the_test_naruto_arena/models/condition.dart';
import 'package:the_test_naruto_arena/models/effect.dart';
import 'package:the_test_naruto_arena/models/enums.dart';
import 'package:the_test_naruto_arena/models/gameinstant.dart';
import 'package:the_test_naruto_arena/models/skill.dart';

class CharInBattle {
  int id;
  String name;
  String img;
  int health;
  List<Effect> attachedEffects;
  int currentSkill_1;
  int currentSkill_2;
  int currentSkill_3;
  int currentSkill_4;
  List<Skill> allSkills;
  Condition? condition;
  bool isOpen;
  CharInBattle({
    required this.id,
    required this.name,
    required this.img,
    required this.health,
    required this.attachedEffects,
    required this.currentSkill_1,
    required this.currentSkill_2,
    required this.currentSkill_3,
    required this.currentSkill_4,
    required this.allSkills,
    required this.condition,
    required this.isOpen,
  });

  factory CharInBattle.empty() {
    return CharInBattle(
      id: 0,
      name: '',
      img: '',
      health: 0,
      attachedEffects: [],
      currentSkill_1: 0,
      currentSkill_2: 0,
      currentSkill_3: 0,
      currentSkill_4: 0,
      allSkills: [],
      condition: null,
      isOpen: false,
    );
  }

  Skill getSkill(int number) {
    switch (number) {
      case 1:
        return allSkills.firstWhere((element) => element.id == currentSkill_1);
      case 2:
        return allSkills.firstWhere((element) => element.id == currentSkill_2);
      case 3:
        return allSkills.firstWhere((element) => element.id == currentSkill_3);
      case 4:
        return allSkills.firstWhere((element) => element.id == currentSkill_4);
      default:
        return allSkills.firstWhere((element) => element.id == currentSkill_1);
    }
  }

  CharInBattle copyWith({
    int? id,
    String? name,
    String? img,
    int? health,
    List<Effect>? attachedEffects,
    int? currentSkill_1,
    int? currentSkill_2,
    int? currentSkill_3,
    int? currentSkill_4,
    List<Skill>? allSkills,
    Condition? condition,
    bool? isOpen,
  }) {
    return CharInBattle(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      health: health ?? this.health,
      attachedEffects: attachedEffects ?? this.attachedEffects,
      currentSkill_1: currentSkill_1 ?? this.currentSkill_1,
      currentSkill_2: currentSkill_2 ?? this.currentSkill_2,
      currentSkill_3: currentSkill_3 ?? this.currentSkill_3,
      currentSkill_4: currentSkill_4 ?? this.currentSkill_4,
      allSkills: allSkills ?? this.allSkills,
      condition: condition ?? this.condition,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'health': health,
      'attachedEffects': attachedEffects.map((x) => x.toMap()).toList(),
      'currentSkill_1': currentSkill_1,
      'currentSkill_2': currentSkill_2,
      'currentSkill_3': currentSkill_3,
      'currentSkill_4': currentSkill_4,
      'allSkills': allSkills.map((x) => x.toMap()).toList(),
      'condition': condition == null ? 'null' : condition!.toMap(),
      'isOpen': isOpen,
    };
  }

  factory CharInBattle.fromMap(Map<String, dynamic> map) {
    return CharInBattle(
      id: map['id'] as int,
      name: map['name'] as String,
      img: map['img'] as String,
      health: map['health'] as int,
      attachedEffects: List<Effect>.from(
        (map['attachedEffects'] as List<dynamic>).map<Effect>(
          (x) => Effect.fromMap(x as Map<String, dynamic>),
        ),
      ),
      currentSkill_1: map['currentSkill_1'] as int,
      currentSkill_2: map['currentSkill_2'] as int,
      currentSkill_3: map['currentSkill_3'] as int,
      currentSkill_4: map['currentSkill_4'] as int,
      allSkills: List<Skill>.from(
        (map['allSkills'] as List<dynamic>).map<Skill>(
          (x) => Skill.fromMap(x as Map<String, dynamic>),
        ),
      ),
      condition: map['condition'] == 'null'
          ? null
          : Condition.fromMap(map['condition'] as Map<String, dynamic>),
      isOpen: map['isOpen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharInBattle.fromJson(String source) =>
      CharInBattle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CharInBattle(id: $id, name: $name, img: $img, health: $health, attachedEffects: $attachedEffects, currentSkill_1: $currentSkill_1, currentSkill_2: $currentSkill_2, currentSkill_3: $currentSkill_3, currentSkill_4: $currentSkill_4, allSkills: $allSkills, condition: $condition, isOpen: $isOpen)';
  }

  @override
  bool operator ==(covariant CharInBattle other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.img == img &&
        other.health == health &&
        listEquals(other.attachedEffects, attachedEffects) &&
        other.currentSkill_1 == currentSkill_1 &&
        other.currentSkill_2 == currentSkill_2 &&
        other.currentSkill_3 == currentSkill_3 &&
        other.currentSkill_4 == currentSkill_4 &&
        listEquals(other.allSkills, allSkills) &&
        other.condition == condition &&
        other.isOpen == isOpen;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        img.hashCode ^
        health.hashCode ^
        attachedEffects.hashCode ^
        currentSkill_1.hashCode ^
        currentSkill_2.hashCode ^
        currentSkill_3.hashCode ^
        currentSkill_4.hashCode ^
        allSkills.hashCode ^
        condition.hashCode ^
        isOpen.hashCode;
  }
}

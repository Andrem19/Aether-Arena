// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:the_test_naruto_arena/models/effect.dart';
import 'package:the_test_naruto_arena/models/gameinstant.dart';
import 'package:the_test_naruto_arena/models/skill.dart';

class CharInBattle {
  String name;
  String img;
  int health;
  List<Effect> attachedEffects;
  int currentSkill_1;
  int currentSkill_2;
  int currentSkill_3;
  int currentSkill_4;
  List<Skill> allSkills;
  CharInBattle({
    required this.name,
    required this.img,
    required this.health,
    required this.attachedEffects,
    required this.currentSkill_1,
    required this.currentSkill_2,
    required this.currentSkill_3,
    required this.currentSkill_4,
    required this.allSkills,
  });

  factory CharInBattle.empty() {
    return CharInBattle(
      name: '',
      img: '',
      health: 0,
      attachedEffects: [],
      currentSkill_1: 0,
      currentSkill_2: 0,
      currentSkill_3: 0,
      currentSkill_4: 0,
      allSkills: [],
    );
  }

  CharInBattle copyWith({
    String? name,
    String? img,
    int? health,
    List<Effect>? attachedEffects,
    int? currentSkill_1,
    int? currentSkill_2,
    int? currentSkill_3,
    int? currentSkill_4,
    List<Skill>? allSkills,
  }) {
    return CharInBattle(
      name: name ?? this.name,
      img: img ?? this.img,
      health: health ?? this.health,
      attachedEffects: attachedEffects ?? this.attachedEffects,
      currentSkill_1: currentSkill_1 ?? this.currentSkill_1,
      currentSkill_2: currentSkill_2 ?? this.currentSkill_2,
      currentSkill_3: currentSkill_3 ?? this.currentSkill_3,
      currentSkill_4: currentSkill_4 ?? this.currentSkill_4,
      allSkills: allSkills ?? this.allSkills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'img': img,
      'health': health,
      'attachedEffects': attachedEffects.map((x) => x.toMap()).toList(),
      'currentSkill_1': currentSkill_1,
      'currentSkill_2': currentSkill_2,
      'currentSkill_3': currentSkill_3,
      'currentSkill_4': currentSkill_4,
      'allSkills': allSkills.map((x) => x.toMap()).toList(),
    };
  }

  factory CharInBattle.fromMap(Map<String, dynamic> map) {
    return CharInBattle(
      name: map['name'] as String,
      img: map['img'] as String,
      health: map['health'] as int,
      attachedEffects: List<Effect>.from((map['attachedEffects'] as List<int>).map<Effect>((x) => Effect.fromMap(x as Map<String,dynamic>),),),
      currentSkill_1: map['currentSkill_1'] as int,
      currentSkill_2: map['currentSkill_2'] as int,
      currentSkill_3: map['currentSkill_3'] as int,
      currentSkill_4: map['currentSkill_4'] as int,
      allSkills: List<Skill>.from((map['allSkills'] as List<int>).map<Skill>((x) => Skill.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CharInBattle.fromJson(String source) => CharInBattle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CharInBattle(name: $name, img: $img, health: $health, attachedEffects: $attachedEffects, currentSkill_1: $currentSkill_1, currentSkill_2: $currentSkill_2, currentSkill_3: $currentSkill_3, currentSkill_4: $currentSkill_4, allSkills: $allSkills)';
  }

  @override
  bool operator ==(covariant CharInBattle other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.img == img &&
      other.health == health &&
      listEquals(other.attachedEffects, attachedEffects) &&
      other.currentSkill_1 == currentSkill_1 &&
      other.currentSkill_2 == currentSkill_2 &&
      other.currentSkill_3 == currentSkill_3 &&
      other.currentSkill_4 == currentSkill_4 &&
      listEquals(other.allSkills, allSkills);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      img.hashCode ^
      health.hashCode ^
      attachedEffects.hashCode ^
      currentSkill_1.hashCode ^
      currentSkill_2.hashCode ^
      currentSkill_3.hashCode ^
      currentSkill_4.hashCode ^
      allSkills.hashCode;
  }
}

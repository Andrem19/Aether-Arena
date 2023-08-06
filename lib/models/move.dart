// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:the_test_naruto_arena/models/enum_serializer.dart';
import 'package:the_test_naruto_arena/models/enums.dart';

import 'skill.dart';

class Move {
  int moveNumber;
  bool isNew;
  Hit char_1;
  Hit char_2;
  Hit char_3;
  Move({
    required this.moveNumber,
    required this.isNew,
    required this.char_1,
    required this.char_2,
    required this.char_3,
  });

  int get totalRandomEnergy {
    int sum = 0;
    if (char_1.skill.requiredEnergy.containsKey(Energy.RANDOM)) {
      sum += char_1.skill.requiredEnergy[Energy.RANDOM]!;
    }
    if (char_2.skill.requiredEnergy.containsKey(Energy.RANDOM)) {
      sum += char_2.skill.requiredEnergy[Energy.RANDOM]!;
    }
    if (char_3.skill.requiredEnergy.containsKey(Energy.RANDOM)) {
      sum += char_3.skill.requiredEnergy[Energy.RANDOM]!;
    }
    return sum;
  }

  static Move empty() {
    return Move(
      moveNumber: 0,
      isNew: false,
      char_1: Hit(
          empty: true,
          target: Target.None,
          skill: Skill.getEmpty(),
          ifOneWho: 0,
          skillId: 0),
      char_2: Hit(
          empty: true,
          target: Target.None,
          skill: Skill.getEmpty(),
          ifOneWho: 0,
          skillId: 0),
      char_3: Hit(
          empty: true,
          target: Target.None,
          skill: Skill.getEmpty(),
          ifOneWho: 0,
          skillId: 0),
    );
  }

  void toEmpty() {
    moveNumber = 0;
    isNew = false;
    char_1 = Hit(
        empty: true,
        target: Target.None,
        skill: Skill.getEmpty(),
        ifOneWho: 0,
        skillId: 0);
    char_2 = Hit(
        empty: true,
        target: Target.None,
        skill: Skill.getEmpty(),
        ifOneWho: 0,
        skillId: 0);
    char_3 = Hit(
        empty: true,
        target: Target.None,
        skill: Skill.getEmpty(),
        ifOneWho: 0,
        skillId: 0);
  }

  Move copyWith({
    int? moveNumber,
    bool? isNew,
    Hit? char_1,
    Hit? char_2,
    Hit? char_3,
  }) {
    return Move(
      moveNumber: moveNumber ?? this.moveNumber,
      isNew: isNew ?? this.isNew,
      char_1: char_1 ?? this.char_1,
      char_2: char_2 ?? this.char_2,
      char_3: char_3 ?? this.char_3,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'moveNumber': moveNumber,
      'isNew': isNew,
      'char_1': char_1.toMap(),
      'char_2': char_2.toMap(),
      'char_3': char_3.toMap(),
    };
  }

  factory Move.fromMap(Map<String, dynamic> map) {
    return Move(
      moveNumber: map['moveNumber'] as int,
      isNew: map['isNew'] as bool,
      char_1: Hit.fromMap(map['char_1'] as Map<String, dynamic>),
      char_2: Hit.fromMap(map['char_2'] as Map<String, dynamic>),
      char_3: Hit.fromMap(map['char_3'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Move.fromJson(String source) =>
      Move.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Move(moveNumber: $moveNumber, isNew: $isNew, char_1: $char_1, char_2: $char_2, char_3: $char_3)';
  }

  @override
  bool operator ==(covariant Move other) {
    if (identical(this, other)) return true;

    return other.moveNumber == moveNumber &&
        other.isNew == isNew &&
        other.char_1 == char_1 &&
        other.char_2 == char_2 &&
        other.char_3 == char_3;
  }

  @override
  int get hashCode {
    return moveNumber.hashCode ^
        isNew.hashCode ^
        char_1.hashCode ^
        char_2.hashCode ^
        char_3.hashCode;
  }
}

class Hit {
  bool empty;
  Target target;
  Skill skill;
  int ifOneWho;
  int skillId;
  Hit({
    required this.empty,
    required this.target,
    required this.skill,
    required this.ifOneWho,
    required this.skillId,
  });

  Hit copyWith({
    bool? empty,
    Target? target,
    Skill? skill,
    int? ifOneWho,
    int? skillId,
  }) {
    return Hit(
      empty: empty ?? this.empty,
      target: target ?? this.target,
      skill: skill ?? this.skill,
      ifOneWho: ifOneWho ?? this.ifOneWho,
      skillId: skillId ?? this.skillId,
    );
  }

  void toEmpty() {
    empty = true;
    target = Target.None;
    skill = Skill.getEmpty();
    ifOneWho = 0;
    skillId = 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'empty': empty,
      'target': EnumSerializer.targetToString(target),
      'skill': skill.toJson(),
      'ifOneWho': ifOneWho,
      'skillId': skillId,
    };
  }

  factory Hit.fromMap(Map<String, dynamic> map) {
    return Hit(
      empty: map['empty'] as bool,
      target: EnumSerializer.targetFromString(map['target']),
      skill: Skill.fromMap(map['skill']),
      ifOneWho: map['ifOneWho'] as int,
      skillId: map['skillId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Hit.fromJson(String source) =>
      Hit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Hit(target: $target, ifOneWho: $ifOneWho, skillId: $skillId)';

  @override
  bool operator ==(covariant Hit other) {
    if (identical(this, other)) return true;

    return other.empty == empty &&
        other.target == target &&
        other.skill == skill &&
        other.ifOneWho == ifOneWho &&
        other.skillId == skillId;
  }

  @override
  int get hashCode =>
      empty.hashCode ^
      target.hashCode ^
      skill.hashCode ^
      ifOneWho.hashCode ^
      skillId.hashCode;
}

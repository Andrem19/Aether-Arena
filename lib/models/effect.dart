// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:the_test_naruto_arena/models/char_in_battle.dart';

import 'enum_serializer.dart';
import 'enums.dart';

class Effect {
  int id;
  String owner;
  CharInBattle whoAttacker;
  int value;
  int value_min;
  int value_max;
  int durationRaund;
  TypeOfAction typeOfAction;
  Target target;
  int skillId;

  Effect({
    required this.id,
    required this.owner,
    required this.whoAttacker,
    required this.value,
    required this.value_min,
    required this.value_max,
    required this.durationRaund,
    required this.typeOfAction,
    required this.target,
    required this.skillId,
  });
  static Effect getEmpty() {
    return Effect(
      id: 0,
      owner: '',
      whoAttacker: CharInBattle.empty(),
      value: 0,
      value_min: 0,
      value_max: 0,
      durationRaund: 0,
      typeOfAction: TypeOfAction.None,
      target: Target.None,
      skillId: 0,
    );
  }

  String toJson() => json.encode(toMap());

  Effect fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  static Effect fromMap(Map<String, dynamic> json) {
    return Effect(
      id: json['id'],
      owner: json['owner'],
      whoAttacker: CharInBattle.fromMap(json['whoAttackerId']),
      value: json['value'],
      value_min: json['value_min'],
      value_max: json['value_max'],
      durationRaund: json['durationRaund'],
      typeOfAction: EnumSerializer.typeOfActionFromString(json['typeOfAction']),
      target: EnumSerializer.targetFromString(json['target']),
      skillId: json['skillId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'owner': owner,
        'whoAttackerId': whoAttacker.toMap(),
        'value': value,
        'value_min': value_min,
        'value_max': value_max,
        'durationRaund': durationRaund,
        'typeOfAction': EnumSerializer.typeOfActionToString(typeOfAction),
        'target': EnumSerializer.targetToString(target),
        'skillId': skillId,
      };
}

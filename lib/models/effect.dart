// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'enum_serializer.dart';
import 'enums.dart';

class Effect {
  int id;
  String name;
  int value;
  int durationRaund;
  TypeOfAction typeOfAction;
  Target target;
  int skillId;

  Effect({
    required this.id,
    required this.name,
    required this.value,
    required this.durationRaund,
    required this.typeOfAction,
    required this.target,
    required this.skillId,
  });
  static Effect getEmpty() {
  return Effect(
    id: 0,
    name: 'null',
    value: 0,
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
      name: json['name'],
      value: json['value'],
      durationRaund: json['durationRaund'],
      typeOfAction: EnumSerializer.typeOfActionFromString(json['typeOfAction']),
      target: EnumSerializer.targetFromString(json['target']),
      skillId: json['skillId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'value': value,
        'durationRaund': durationRaund,
        'typeOfAction': EnumSerializer.typeOfActionToString(typeOfAction),
        'target': EnumSerializer.targetToString(target),
        'skillId': skillId,
      };
  
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'enum_serializer.dart';
import 'enums.dart';

class Effect {
  int id;
  String name;
  String img;
  bool randomValue;
  List<int> ifRandomFromTo;
  int value;
  Energy typeOfEnergyIfRemoveOrSteelOrAdd;
  EnergyEffect energyEffect;
  int durationRaund;
  bool IgnoreInvulnerability;
  bool IgnoreCounter;
  TypeOfAction typeOfAction;
  Target target;
  SkillType skillType;
  Distance distance;
  PersistenceType persistenceType;
  int skillId;

  Effect({
    required this.id,
    required this.name,
    required this.img,
    required this.randomValue,
    required this.ifRandomFromTo,
    required this.value,
    required this.typeOfEnergyIfRemoveOrSteelOrAdd,
    required this.energyEffect,
    required this.durationRaund,
    required this.IgnoreInvulnerability,
    required this.IgnoreCounter,
    required this.typeOfAction,
    required this.target,
    required this.skillType,
    required this.distance,
    required this.persistenceType,
    required this.skillId,
  });
  static Effect getEmpty() {
  return Effect(
    id: 0,
    name: 'null',
    img: 'null',
    randomValue: false,
    ifRandomFromTo: [],
    value: 0,
    typeOfEnergyIfRemoveOrSteelOrAdd: Energy.NONE,
    energyEffect: EnergyEffect.None,
    durationRaund: 0,
    IgnoreInvulnerability: false,
    IgnoreCounter: false,
    typeOfAction: TypeOfAction.None,
    target: Target.None,
    skillType: SkillType.None,
    distance: Distance.None,
    persistenceType: PersistenceType.None,
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
      img: json['img'],
      randomValue: json['randomValue'],
      ifRandomFromTo: List<int>.from(json['ifRandomFromTo']),
      value: json['value'],
      typeOfEnergyIfRemoveOrSteelOrAdd:
          EnumSerializer.energyFromString(json['typeOfEnergyIfRemoveOrSteelOrAdd']),
      energyEffect: EnumSerializer.energyEffectFromString(json['energyEffect']),
      durationRaund: json['durationRaund'],
      IgnoreInvulnerability: json['ignoreInvulnerability'],
      IgnoreCounter: json['ignoreCounter'],
      typeOfAction: EnumSerializer.typeOfActionFromString(json['typeOfAction']),
      target: EnumSerializer.targetFromString(json['target']),
      skillType: EnumSerializer.skillTypeFromString(json['skillType']),
      distance: EnumSerializer.distanceFromString(json['distance']),
      persistenceType: EnumSerializer.persistenceTypeFromString(json['persistenceType']),
      skillId: json['skillId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'img': img,
        'randomValue': randomValue,
        'ifRandomFromTo': ifRandomFromTo,
        'value': value,
        'typeOfEnergyIfRemoveOrSteelOrAdd':
            EnumSerializer.energyToString(typeOfEnergyIfRemoveOrSteelOrAdd),
        'energyEffect': EnumSerializer.energyEffectToString(energyEffect),
        'durationRaund': durationRaund,
        'ignoreInvulnerability': IgnoreInvulnerability,
        'ignoreCounter': IgnoreCounter,
        'typeOfAction': EnumSerializer.typeOfActionToString(typeOfAction),
        'target': EnumSerializer.targetToString(target),
        'skillType': EnumSerializer.skillTypeToString(skillType),
        'distance': EnumSerializer.distanceToString(distance),
        'persistenceType': EnumSerializer.persistenceTypeToString(persistenceType),
        'skillId': skillId,
      };
  
}

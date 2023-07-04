// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'condition.dart';

class Character {
  int id;
  String name;
  String img;
  List<Skill> skills;
  bool isOpen;
  Condition? condition;
  Character({
    required this.id,
    required this.name,
    required this.img,
    required this.skills,
    required this.isOpen,
    required this.condition,
  });
}

class Skill {
  String name;
  String img;
  String energy;
  String target;
  String effect;
  int duration;
  int cooldown;
  Skill({
    required this.name,
    required this.img,
    required this.energy,
    required this.target,
    required this.effect,
    required this.duration,
    required this.cooldown,
  });
}

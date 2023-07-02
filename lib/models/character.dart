// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_test_naruto_arena/models/skill.dart';

class Character {
  int id;
  String name;
  String img;
  List<Skill> skills;
  Character({
    required this.id,
    required this.name,
    required this.img,
    required this.skills,
  });
}

class Skill {
  String name;
  String energy;
  String target;
  String effect;
  int duration;
  int cooldown;
  Skill({
    required this.name,
    required this.energy,
    required this.target,
    required this.effect,
    required this.duration,
    required this.cooldown,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  List<Skill> allSkills;
  CharInBattle({
    required this.name,
    required this.img,
    required this.health,
    required this.attachedEffects,
    required this.currentSkill_1,
    required this.currentSkill_2,
    required this.currentSkill_3,
    required this.allSkills,
  });
}

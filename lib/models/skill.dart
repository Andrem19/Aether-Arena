// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'effect.dart';
import 'enums.dart';

class Skill {
  String name;
  String img;
  List<Energy> requiredEnergy;
  int cooldown;
  List<Effect> effects;
  Skill({
    required this.name,
    required this.img,
    required this.requiredEnergy,
    required this.cooldown,
    required this.effects,
  });
}

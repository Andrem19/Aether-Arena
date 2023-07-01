// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

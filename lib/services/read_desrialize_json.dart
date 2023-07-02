import 'dart:convert';

import 'package:the_test_naruto_arena/data/characters.dart';

import '../models/character.dart';
import '../models/condition.dart';

class ReadJson {
  static Future<List<Character>> readCharactersFromFile() async {
    List<dynamic> jsonList = jsonDecode(Chars.chars);
    List<Character> characters = [];

    for (var jsonObj in jsonList) {
      var id = jsonObj['id'];
      var name = jsonObj['name'];
      var img = jsonObj['img'];
      var isOpen = jsonObj['isOpen'];
      var condition = jsonObj['condition'];
      var skillJsonList = jsonObj['Skills'];
      List<Skill> skills = [];

      for (var skillJson in skillJsonList) {
        var imgSkill = skillJson['img'];
        var skillName = skillJson['name'];
        var energy = skillJson['Energy'];
        var target = skillJson['Target'];
        var effect = skillJson['Effect'];
        var duration = skillJson['Duration'];
        var cooldown = skillJson['Cooldown'];

        Skill skill = Skill(
          img: imgSkill,
          name: skillName,
          energy: energy,
          target: target,
          effect: effect,
          duration: duration,
          cooldown: cooldown,
        );

        skills.add(skill);
      }
      Character character = Character(
        id: id,
        name: name,
        img: img,
        isOpen: isOpen,
        condition: condition == null ? null : Condition.fromMap(condition),
        skills: skills,
      );

      characters.add(character);
    }

    return characters;
  }
}

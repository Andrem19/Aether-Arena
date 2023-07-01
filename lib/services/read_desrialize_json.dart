import 'dart:convert';

import 'package:the_test_naruto_arena/data/characters.dart';

import '../models/character.dart';

class ReadJson {
  static Future<List<Character>> readCharactersFromFile() async {

  List<dynamic> jsonList = jsonDecode(Chars.chars);
  List<Character> characters = [];

  for (var jsonObj in jsonList) {
    var name = jsonObj['name'];
    var img = jsonObj['img'];
    var open = jsonObj['open'];
    var skillJsonList = jsonObj['Skills'];
    List<Skill> skills = [];

    for (var skillJson in skillJsonList) {
      var skillName = skillJson['name'];
      var energy = skillJson['Energy'];
      var target = skillJson['Target'];
      var effect = skillJson['Effect'];
      var duration = skillJson['Duration'];
      var cooldown = skillJson['Cooldown'];

      Skill skill = Skill(
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
      name: name,
      img: img,
      open: open,
      skills: skills,
    );

    characters.add(character);
  }

  return characters;
}
}
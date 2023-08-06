import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/models/move.dart';

import '../models/skill.dart';

class ChoosenSkill {
  static Widget getChoosenSkill(int position, double width) {
    return GetBuilder<BattleController>(builder: (controller) {
      Skill skill = getSkillFromMove(position, controller);
      return InkWell(
        onLongPress: () {
          controller.returnEnergy(skill);
          removeSkillFromMove(position, controller);
        },
        onTap: () {
          controller.needCurrentSkill.value = skill.requiredEnergy;
          controller.infoText.value = skill.description;
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
          child: Container(
            width: width * 0.1,
            height: width * 0.1,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Stack(children: [
              skill.img == ''
                  ? Image.asset('assets/default_avatar.jpg')
                  : Image.asset(skill.img),
              Text('')
            ]),
          ),
        ),
      );
    });
  }

  static Skill getSkillFromMove(int position, BattleController cont) {
    if (cont.my_move.value.isNew) {
      switch (position) {
        case 1:
          return cont.my_char_1.value.allSkills.firstWhere(
              (element) => element.id == cont.my_move.value.char_1.skillId,
              orElse: () => Skill.getEmpty());
        case 2:
          return cont.my_char_2.value.allSkills.firstWhere(
              (element) => element.id == cont.my_move.value.char_2.skillId,
              orElse: () => Skill.getEmpty());
        case 3:
          return cont.my_char_3.value.allSkills.firstWhere(
              (element) => element.id == cont.my_move.value.char_3.skillId,
              orElse: () => Skill.getEmpty());
        default:
          return Skill.getEmpty();
      }
    } else {
      return Skill.getEmpty();
    }
  }

  static void removeSkillFromMove(int position, BattleController cont) {
    switch (position) {
      case 1:
        cont.my_move.value.char_1.toEmpty();
        break;
      case 2:
        cont.my_move.value.char_2.toEmpty();
        break;
      case 3:
        cont.my_move.value.char_3.toEmpty();
        break;
      default:
    }
    cont.update();
  }
}

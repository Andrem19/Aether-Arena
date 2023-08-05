import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/models/enums.dart';

import '../models/skill.dart';

class BattleMySkill {
  static Widget getMySkill(int position, Skill skill, double width) {
    return GetBuilder<BattleController>(builder: (controller) {
      bool isSkillAvalible = isAvailable(skill, controller);
      print('isSkillAvalible: $isSkillAvalible');
      return InkWell(
        onTap: () {
          if (isSkillAvalible) {
            controller.stopTimerBlinking();
            var main_cont = Get.find<MainGameController>();
            controller.charFocus = position;
            controller.skillFocus = skill.id;
            controller.infoText.value = skill.description;
            controller.needCurrentSkill.value = skill.requiredEnergy;
            controller.setCharFocus(getCharId(position, controller));
            controller.setSkillFocus(skill);
            if (skill.target == Target.AllAliveAlly ||
                skill.target == Target.SingleAlly) {
              controller.allyClicable.value = true;
              controller.startTimerBliking(controller.chooseTargetAlly);
            } else if (skill.target == Target.AllAliveAnemy ||
                skill.target == Target.SingleEnemyTarget ||
                skill.target == Target.RandomEnemyTarget) {
              controller.enemyClicable.value = true;
              controller.startTimerBliking(controller.chooseTargetEnemy);
            } else if (skill.target == Target.AllAliveInGame ||
                skill.target == Target.RandomAllTarget) {
              controller.allClicable.value = true;
              controller.startTimerBliking(controller.chooseTargetAll);
            } else if (skill.target == Target.Myself) {
              controller.meClicable.value = true;
              controller.startTimerBliking(controller.chooseTargetMe);
            }
          } else {
            controller.needCurrentSkill.value = skill.requiredEnergy;
            controller.charFocus = position;
            controller.skillFocus = 0;
            controller.infoText.value = skill.description;
            controller.clearFocus();
            controller.stopTimerBlinking();
          }

          controller.update();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
          child: Opacity(
            opacity: isSkillAvalible ? 1.0 : 0.4,
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                boxShadow: controller.skillFocus == skill.id &&
                        controller.charFocus == position &&
                        isSkillAvalible
                    ? [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: Stack(children: [
                skill.img == ''
                    ? Image.asset('assets/default_skill.jpg')
                    : Image.asset(skill.img),
                Text(skill.name),
              ]),
            ),
          ),
        ),
      );
    });
  }

  static int getCharId(int position, BattleController cont) {
    switch (position) {
      case 1:
        return cont.my_char_1.value.id;
      case 2:
        return cont.my_char_2.value.id;
      case 3:
        return cont.my_char_3.value.id;
      default:
        return 0;
    }
  }

  static bool isAvailable(Skill skill, BattleController cont) {
    Map<Energy, int> energy = Map.from(cont.myEnergy.value);

    if (skill.requiredEnergy.isNotEmpty) {
      for (var entry in skill.requiredEnergy.entries) {
        var key = entry.key;
        var value = entry.value;

        if (key != Energy.RANDOM) {
          if (energy[key]! < value) {
            return false;
          }
          energy[key] = energy[key]! - value;
        }
      }
    }

    Map<Energy, int> reqEnergy = Map.from(skill.requiredEnergy);
    if (reqEnergy.containsKey(Energy.RANDOM)) {
      int sum = 0;
      for (var entry in energy.entries) {
        var key = entry.key;
        var value = entry.value;
        if (key != Energy.RANDOM) {
          sum += energy[key]!;
        }
      }

      if (sum < reqEnergy[Energy.RANDOM]!) {
        return false;
      }
    }
    return true;
  }
}

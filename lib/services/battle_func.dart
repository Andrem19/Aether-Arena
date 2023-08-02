import 'dart:math';

import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/models/char_in_battle.dart';
import 'package:the_test_naruto_arena/models/enums.dart';

import '../models/effect.dart';
import '../models/skill.dart';

class BattleFunc {
  static Skill getAttackSkill(CharInBattle char, int skill_id) {
    return char.allSkills.firstWhere((element) => element.id == skill_id);
  }

  static void addEffects(Skill skill) {
    var battleCont = Get.find<BattleController>();
    for (var i = 0; i < skill.effects.length; i++) {
      if (skill.effects[i].target == Target.AllAliveAlly) {
        if (battleCont.my_char_1.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_3.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
      } else if (skill.effects[i].target == Target.AllAliveAnemy) {
        if (battleCont.enemy_char_1.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_1.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_2.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_2.value);
        }
      } else if (skill.effects[i].target == Target.AllAliveInGame) {
        if (battleCont.my_char_1.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_3.value.health > 0) {
          addEffect(skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.enemy_char_1.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_1.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_2.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(skill.effects[i], battleCont.enemy_char_2.value);
        }
      } else if (skill.effects[i].target == Target.RandomEnemyTarget) {
        
        int rand = Random().nextInt(3) + 1;
        if (rand == 1) {
          
        } else if (rand == 2) {

        } else if (rand == 3) {

        }
      } else if (skill.effects[i].target == Target.RandomAllTarget) {
      } else if (skill.effects[i].target == Target.SingleAlly) {
      } else if (skill.effects[i].target == Target.SingleEnemyTarget) {
      } else if (skill.effects[i].target == Target.Myself) {}
    }
  }

  static void execEffect(Effect effect, CharInBattle char) {
    if (effect.typeOfAction == TypeOfAction.Attack) {
    } else if (effect.typeOfAction == TypeOfAction.Defence) {
    } else if (effect.typeOfAction == TypeOfAction.Heal) {
    } else if (effect.typeOfAction == TypeOfAction.Poison) {
    } else if (effect.typeOfAction == TypeOfAction.Break) {
    } else if (effect.typeOfAction == TypeOfAction.Dexterity) {
    } else if (effect.typeOfAction == TypeOfAction.Intelligence) {
    } else if (effect.typeOfAction == TypeOfAction.Strength) {
    } else if (effect.typeOfAction == TypeOfAction.Weaken) {}
  }

  static void addEffect(Effect effect, CharInBattle char) {
    char.attachedEffects.add(effect);
  }
}

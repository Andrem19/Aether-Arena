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

  static void addEffects(
      String owner, int whoAttackerId, Skill skill, int targetIfOne) {
    var battleCont = Get.find<BattleController>();
    for (var i = 0; i < skill.effects.length; i++) {
      skill.effects[i].value = getEffectValue(
          skill.effects[i].value_min, skill.effects[i].value_max);
      if (skill.effects[i].target == Target.AllAliveAlly) {
        if (battleCont.my_char_1.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_2.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_2.value);
        }
        if (battleCont.my_char_3.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_3.value);
        }
      } else if (skill.effects[i].target == Target.AllAliveAnemy) {
        if (battleCont.enemy_char_1.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_1.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_2.value);
        }
        if (battleCont.enemy_char_3.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_3.value);
        }
      } else if (skill.effects[i].target == Target.AllAliveInGame) {
        if (battleCont.my_char_1.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_1.value);
        }
        if (battleCont.my_char_2.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_2.value);
        }
        if (battleCont.my_char_3.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_3.value);
        }
        if (battleCont.enemy_char_1.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_1.value);
        }
        if (battleCont.enemy_char_2.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_2.value);
        }
        if (battleCont.enemy_char_3.value.health > 0) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_3.value);
        }
      } else if (skill.effects[i].target == Target.RandomEnemyTarget) {
        int rand = getAliveEnemyRand(battleCont);
        if (rand == 1) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_1.value);
        } else if (rand == 2) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_2.value);
        } else if (rand == 3) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_3.value);
        }
      } else if (skill.effects[i].target == Target.RandomAllTarget) {
        int rand = getAliveAllRand(battleCont);
        if (rand == 1) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_1.value);
        } else if (rand == 2) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_2.value);
        } else if (rand == 3) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_3.value);
        } else if (rand == 4) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_1.value);
        } else if (rand == 5) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_2.value);
        } else if (rand == 6) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_3.value);
        }
      } else if (skill.effects[i].target == Target.SingleAlly) {
        if (targetIfOne == battleCont.my_char_1.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_1.value);
        } else if (targetIfOne == battleCont.my_char_2.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_2.value);
        } else if (targetIfOne == battleCont.my_char_3.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_3.value);
        }
      } else if (skill.effects[i].target == Target.SingleEnemyTarget) {
        if (targetIfOne == battleCont.enemy_char_1.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_1.value);
        } else if (targetIfOne == battleCont.enemy_char_2.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_2.value);
        } else if (targetIfOne == battleCont.enemy_char_3.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.enemy_char_3.value);
        }
      } else if (skill.effects[i].target == Target.Myself) {
        if (whoAttackerId == battleCont.my_char_1.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_1.value);
        } else if (whoAttackerId == battleCont.my_char_2.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_2.value);
        } else if (whoAttackerId == battleCont.my_char_3.value.id) {
          addEffect(whoAttackerId, owner, skill.effects[i], battleCont.my_char_3.value);
        }
      }
    }
  }

  static void execEffect(String myRole, Effect effect, CharInBattle targetChar,
      CharInBattle attackerChar) {
    if (myRole == effect.owner) {
      if (targetChar.weaken > 0) {
        targetChar.weaken--;
      }
      if (effect.typeOfAction == TypeOfAction.Attack) {
        int def = getDefence(targetChar);
        int damage = effect.value;
        if (attackerChar.weaken > 0) {
          damage *= 0.75.toInt();
        }
        if (def < damage) {
          int rest = def - damage;
          targetChar.health -= rest;
        }
        reduceDefence(targetChar, damage);
      } else if (effect.typeOfAction == TypeOfAction.Defence) {
      } else if (effect.typeOfAction == TypeOfAction.Heal) {
        targetChar.health += effect.value;
      } else if (effect.typeOfAction == TypeOfAction.Poison) {
      } else if (effect.typeOfAction == TypeOfAction.Break) {
      } else if (effect.typeOfAction == TypeOfAction.Dexterity) {
      } else if (effect.typeOfAction == TypeOfAction.Intelligence) {
      } else if (effect.typeOfAction == TypeOfAction.Strength) {
      } else if (effect.typeOfAction == TypeOfAction.Weaken) {
        targetChar.weaken++;
      }

      if (effect.durationRaund < 1000) {
        effect.durationRaund -= 1;
      }
      if (effect.durationRaund < 1) {
        targetChar.attachedEffects.remove(effect);
      }
    }
  }

  static void addEffect(int whoAttakerId, String owner, Effect effect, CharInBattle char) {
    effect.owner = owner;
    char.attachedEffects.add(effect);
  }

  static int getAliveEnemyRand(BattleController battleCont) {
    int rand = Random().nextInt(3) + 1;
    if ((rand == 1 && battleCont.enemy_char_1.value.health <= 0) ||
        (rand == 2 && battleCont.enemy_char_2.value.health <= 0) ||
        (rand == 3 && battleCont.enemy_char_3.value.health <= 0)) {
      if (battleCont.enemy_char_1.value.health <= 0 &&
          battleCont.enemy_char_2.value.health <= 0 &&
          battleCont.enemy_char_3.value.health <= 0) {
        return 0;
      }
      getAliveEnemyRand(battleCont);
    }
    return rand;
  }

  static int getAliveAllRand(BattleController battleCont) {
    int rand = Random().nextInt(6) + 1;
    if ((rand == 1 && battleCont.enemy_char_1.value.health <= 0) ||
        (rand == 2 && battleCont.enemy_char_2.value.health <= 0) ||
        (rand == 3 && battleCont.enemy_char_3.value.health <= 0) ||
        (rand == 4 && battleCont.my_char_1.value.health <= 0) ||
        (rand == 5 && battleCont.my_char_2.value.health <= 0) ||
        (rand == 6 && battleCont.my_char_3.value.health <= 0)) {
      if (battleCont.enemy_char_1.value.health <= 0 &&
          battleCont.enemy_char_2.value.health <= 0 &&
          battleCont.enemy_char_3.value.health <= 0 &&
          battleCont.my_char_1.value.health <= 0 &&
          battleCont.my_char_2.value.health <= 0 &&
          battleCont.my_char_3.value.health <= 0) {
        return 0;
      }
      getAliveAllRand(battleCont);
    }
    return rand;
  }

  static int getEffectValue(int min, int max) {
    if (min == max) {
      return max;
    }
    return Random().nextInt(max + 1) + min;
  }

  static int getDefence(CharInBattle char) {
    int def = 0;
    for (var element in char.attachedEffects) {
      if (element.typeOfAction == TypeOfAction.Defence) {
        def += getEffectValue(element.value_min, element.value_max);
      }
    }
    return def;
  }

  static void reduceDefence(CharInBattle char, int val) {
    int value = val;
    for (var element in char.attachedEffects) {
      if (element.typeOfAction == TypeOfAction.Defence) {
        if (value < 1) {
          return;
        }
        if (element.value <= value) {
          value - element.value;
          char.attachedEffects.remove(element);
        } else if (element.value > value) {
          element.value -= value;
        }
      }
    }
  }
}

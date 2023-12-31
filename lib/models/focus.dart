// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_test_naruto_arena/models/char_in_battle.dart';
import 'package:the_test_naruto_arena/models/enums.dart';
import 'package:the_test_naruto_arena/models/skill.dart';

class Focus {
  bool isEmpty;
  int myCharId;
  int skill_id;
  Skill skill;
  Target target;
  int target_idIfOne;
  Focus({
    required this.isEmpty,
    required this.myCharId,
    required this.skill_id,
    required this.skill,
    required this.target,
    required this.target_idIfOne,
  });

  static Focus empty() {
    return Focus(
        isEmpty: true,
        myCharId: 0,
        skill: Skill.getEmpty(),
        skill_id: 0,
        target: Target.None,
        target_idIfOne: 0);
  }

  void clearFocus() {
    isEmpty = true;
    myCharId = 0;
    skill_id = 0;
    target = Target.None;
    target_idIfOne = 0;
  }

  void setUpChar(int id) {
    isEmpty = false;
    myCharId = id;
  }

  void setUpSkill(List<CharInBattle> chars, Skill current_skill) {
    if (isEmpty == false) {
      CharInBattle char = chars.firstWhere((element) => element.id == myCharId,
          orElse: CharInBattle.empty);
      if (char != CharInBattle.empty()) {
        skill_id = current_skill.id;
        skill = current_skill;
        target = current_skill.target;
      }
    } else {
      print('Skill cant be choosen');
    }
  }

  void setUpTarget_id(int targetId) {
    if (target == Target.SingleEnemyTarget) {
      target_idIfOne = targetId;
    }
  }
}

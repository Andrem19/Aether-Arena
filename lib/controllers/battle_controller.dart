import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/models/char_in_battle.dart';
import 'package:the_test_naruto_arena/services/battle_func.dart';

import '../models/account_player_data.dart';
import '../models/enums.dart';
import '../models/focus.dart';
import '../models/move.dart';
import '../models/skill.dart';
import 'main_game_controller.dart';

class BattleController extends GetxController {
  int timeOfMove = 21;
  RxString infoText = ''.obs;
  Rx<Map<Energy, int>> needCurrentSkill = Rx<Map<Energy, int>>({});
  String enemy_role = 'B';
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final MainGameController _mainContr = Get.find<MainGameController>();
  AccountPlayerData my_accData = AccountPlayerData.empty();
  AccountPlayerData enemy_accData = AccountPlayerData.empty();
  Rx<Map<Energy, int>> myEnergy = Rx<Map<Energy, int>>({
    Energy.ARCANE: 2,
    Energy.PHYSICAL: 0,
    Energy.UNIQUE: 1,
    Energy.WILLPOWER: 1,
  });
  Rx<Map<Energy, int>> randomIGive = Rx<Map<Energy, int>>({
    Energy.ARCANE: 0,
    Energy.PHYSICAL: 0,
    Energy.UNIQUE: 0,
    Energy.WILLPOWER: 0,
  });
  int get totalEnergyCount {
    int sum = 0;
    myEnergy.value.forEach((energy, count) {
      sum += count;
    });
    return sum;
  }

  RxBool chooseTargetEnemy = false.obs;
  RxBool chooseTargetAlly = false.obs;
  RxBool chooseTargetAll = false.obs;
  RxBool chooseTargetMe = false.obs;
  RxBool enemyClicable = false.obs;
  RxBool allyClicable = false.obs;
  RxBool allClicable = false.obs;
  RxBool meClicable = false.obs;
  Rx<Move> my_move = Move.empty().obs;
  Move enemy_move = Move.empty();
  Focus focus = Focus.empty();

  int charFocus = 0;
  int skillFocus = 0;

  Rx<CharInBattle> my_char_1 = CharInBattle.empty().obs;
  Rx<CharInBattle> my_char_2 = CharInBattle.empty().obs;
  Rx<CharInBattle> my_char_3 = CharInBattle.empty().obs;

  Rx<CharInBattle> enemy_char_1 = CharInBattle.empty().obs;
  Rx<CharInBattle> enemy_char_2 = CharInBattle.empty().obs;
  Rx<CharInBattle> enemy_char_3 = CharInBattle.empty().obs;

  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _listener;
  Timer? _timer;
  Timer? _timer_bliking;

  final RxInt timerValue = 21.obs;
  final RxString whoIsMove = ''.obs;

  String currentGameId = '';
  String myRole = '';

  @override
  void onInit() async {
    // await setUpVars();
    // _startListener();
    super.onInit();
  }

  @override
  void onClose() {
    _updatePlayerReady();
    _mainContr.deleteGameInstant();
    _timer?.cancel();
    _timer_bliking?.cancel();
    super.onClose();
  }

  Future<void> startGame() async {
    await setUpVars();
    _startListener();
  }

  Future<void> setUpVars() async {
    myRole = _mainContr.curentRole;
    enemy_role = myRole == 'A' ? 'B' : 'A';
    final doc = await _firebaseFirestore
        .collection('battles')
        .doc(_mainContr.curentGameId)
        .get();
    final data = doc.data();
    whoIsMove.value = data!['WhosMove'];
    currentGameId = _mainContr.curentGameId;

    var Achar_1 = CharInBattle.fromJson(data['playerA_char_1']);
    var Achar_2 = CharInBattle.fromJson(data['playerA_char_2']);
    var Achar_3 = CharInBattle.fromJson(data['playerA_char_3']);

    var Bchar_1 = CharInBattle.fromJson(data['playerB_char_1']);
    var Bchar_2 = CharInBattle.fromJson(data['playerB_char_2']);
    var Bchar_3 = CharInBattle.fromJson(data['playerB_char_3']);

    my_accData = myRole == 'A'
        ? AccountPlayerData.fromJson(data['PlayerA_accData'])
        : AccountPlayerData.fromJson(data['PlayerB_accData']);
    enemy_accData = myRole == 'A'
        ? AccountPlayerData.fromJson(data['PlayerB_accData'])
        : AccountPlayerData.fromJson(data['PlayerA_accData']);

    if (myRole == 'A') {
      my_char_1.value = Achar_1;
      my_char_2.value = Achar_2;
      my_char_3.value = Achar_3;

      enemy_char_1.value = Bchar_1;
      enemy_char_2.value = Bchar_2;
      enemy_char_3.value = Bchar_3;
    } else {
      my_char_1.value = Bchar_1;
      my_char_2.value = Bchar_2;
      my_char_3.value = Bchar_3;

      enemy_char_1.value = Achar_1;
      enemy_char_2.value = Achar_2;
      enemy_char_3.value = Achar_3;
    }

    timerValue.value = timeOfMove;
    if (whoIsMove.value == myRole) {
      _startTimerMove();
    }
    update();
  }

  void _startListener() {
    final snapshots =
        _firebaseFirestore.collection('battles').doc(currentGameId).snapshots();
    _listener = snapshots.listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        whoIsMove.value = data!['WhosMove'];

        var Achar_1 = CharInBattle.fromJson(data['playerA_char_1']);
        var Achar_2 = CharInBattle.fromJson(data['playerA_char_2']);
        var Achar_3 = CharInBattle.fromJson(data['playerA_char_3']);

        var Bchar_1 = CharInBattle.fromJson(data['playerB_char_1']);
        var Bchar_2 = CharInBattle.fromJson(data['playerB_char_2']);
        var Bchar_3 = CharInBattle.fromJson(data['playerB_char_3']);

        if (myRole == 'A') {
          my_char_1.value = Achar_1;
          my_char_2.value = Achar_2;
          my_char_3.value = Achar_3;

          enemy_char_1.value = Bchar_1;
          enemy_char_2.value = Bchar_2;
          enemy_char_3.value = Bchar_3;
        } else {
          my_char_1.value = Bchar_1;
          my_char_2.value = Bchar_2;
          my_char_3.value = Bchar_3;

          enemy_char_1.value = Achar_1;
          enemy_char_2.value = Achar_2;
          enemy_char_3.value = Achar_3;
        }

        if (whoIsMove.value == myRole && _timer == null) {
          timerValue.value = timeOfMove;
          // loadMove();
          _startTimerMove();
        }
        if (whoIsMove.value != myRole) {
          timerValue.value = timeOfMove;
          _timer?.cancel();
          _timer = null;
        }
        update();
      }
    });
  }

  Future<void> _updatePlayerReady() async {
    await _firebaseFirestore.collection('battles').doc(currentGameId).update({
      'Player${myRole}_ready': false,
    });
  }

  void _startTimerMove() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timerValue.value--;
      update();
      if (timerValue == 0) {
        // saveMove();
        timerValue.value = timeOfMove;
        _timer?.cancel();
        _setUpNextMove();
        update();
      }
    });
  }

  Future<void> _setUpNextMove() async {
    whoIsMove.value = myRole == 'A' ? 'B' : 'A';
    await _firebaseFirestore.collection('battles').doc(currentGameId).update({
      'WhosMove': myRole == 'A' ? 'B' : 'A',
    });
  }

  void applyMyMove() {
    if (my_move.value.isNew == true) {
      Skill skill_1 =
          BattleFunc.getAttackSkill(my_char_1.value, my_move.value.char_1.skillId);
      BattleFunc.addEffects(
          myRole, my_char_1.value, skill_1, my_move.value.char_1.ifOneWho);
      Skill skill_2 =
          BattleFunc.getAttackSkill(my_char_2.value, my_move.value.char_2.skillId);
      BattleFunc.addEffects(
          myRole, my_char_2.value, skill_2, my_move.value.char_2.ifOneWho);
      Skill skill_3 =
          BattleFunc.getAttackSkill(my_char_3.value, my_move.value.char_3.skillId);
      BattleFunc.addEffects(
          myRole, my_char_3.value, skill_3, my_move.value.char_3.ifOneWho);
    }
  }

  void execMyMove() {
    charLoop(my_char_1.value, true);
    charLoop(my_char_2.value, true);
    charLoop(my_char_3.value, true);
    charLoop(enemy_char_1.value, false);
    charLoop(enemy_char_2.value, false);
    charLoop(enemy_char_3.value, false);
    saveMove();
  }

  void charLoop(CharInBattle targetChar, bool isMine) {
    if (isMine) {
      if (targetChar.stats.weaken > 0) {
        targetChar.stats.weaken--;
      }
    }
    if (!isMine) {
      if (targetChar.stats.poison >= 2) {
        int damage = (targetChar.stats.poison / 2).toInt();
        addRemoveHealsAnimated(targetChar, false, damage);
      } else if (targetChar.stats.poison < 2 && targetChar.stats.poison > 0) {
        targetChar.stats.poison = 0;
      }
    }
    for (var i = 0; i < targetChar.attachedEffects.length; i++) {
      BattleFunc.execEffect(myRole, targetChar.attachedEffects[i], targetChar);
    }
  }

  void saveMove() async {
    await _firebaseFirestore.collection('battles').doc(currentGameId).update({
      'playerA_char_1': myRole == 'A'
          ? my_char_1.value.toJson()
          : enemy_char_1.value.toJson(),
      'playerA_char_2': myRole == 'A'
          ? my_char_2.value.toJson()
          : enemy_char_2.value.toJson(),
      'playerA_char_3': myRole == 'A'
          ? my_char_3.value.toJson()
          : enemy_char_3.value.toJson(),
      'playerB_char_1': myRole == 'B'
          ? my_char_1.value.toJson()
          : enemy_char_1.value.toJson(),
      'playerB_char_2': myRole == 'B'
          ? my_char_2.value.toJson()
          : enemy_char_2.value.toJson(),
      'playerB_char_3': myRole == 'B'
          ? my_char_3.value.toJson()
          : enemy_char_3.value.toJson(),
    });
  }

  void loadMove() async {
    var doc =
        await _firebaseFirestore.collection('battles').doc(currentGameId).get();
    var data = doc.data();
  }

  void setCharFocus(int id) {
    focus.setUpChar(id);
  }

  void setSkillFocus(Skill skill) {
    focus.setUpSkill(_mainContr.characters, skill);
  }

  void setTarget(int targetId) {
    focus.setUpTarget_id(targetId);
  }

  void clearFocus() {
    focus.clearFocus();
  }

  void passFocusToTheMove() {
    if (focus.myCharId == my_char_1.value.id) {
      if (!my_move.value.char_1.empty) {
        returnEnergy(my_move.value.char_1.skill);
      }
      my_move.value.char_1.skillId = focus.skill_id;
      my_move.value.char_1.target = focus.target;
      my_move.value.char_1.skill = focus.skill;
      my_move.value.char_1.ifOneWho = focus.target_idIfOne;
      my_move.value.char_1.empty = false;
      my_move.value.isNew = true;
    } else if (focus.myCharId == my_char_2.value.id) {
      if (!my_move.value.char_2.empty) {
        returnEnergy(my_move.value.char_2.skill);
      }
      my_move.value.char_2.skillId = focus.skill_id;
      my_move.value.char_2.target = focus.target;
      my_move.value.char_2.skill = focus.skill;
      my_move.value.char_2.ifOneWho = focus.target_idIfOne;
      my_move.value.char_2.empty = false;
      my_move.value.isNew = true;
    } else if (focus.myCharId == my_char_3.value.id) {
      if (!my_move.value.char_3.empty) {
        returnEnergy(my_move.value.char_3.skill);
      }
      my_move.value.char_3.skillId = focus.skill_id;
      my_move.value.char_3.target = focus.target;
      my_move.value.char_3.skill = focus.skill;
      my_move.value.char_3.ifOneWho = focus.target_idIfOne;
      my_move.value.char_3.empty = false;
      my_move.value.isNew = true;
    }
    subtractEnergy(focus.skill);
    update();
  }

  void subtractEnergy(Skill skill) {
    if (skill.requiredEnergy.containsKey(Energy.ARCANE)) {
      int res =
          myEnergy.value[Energy.ARCANE]! - skill.requiredEnergy[Energy.ARCANE]!;
      myEnergy.value[Energy.ARCANE] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.PHYSICAL)) {
      int res = myEnergy.value[Energy.PHYSICAL]! -
          skill.requiredEnergy[Energy.PHYSICAL]!;
      myEnergy.value[Energy.PHYSICAL] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.UNIQUE)) {
      int res =
          myEnergy.value[Energy.UNIQUE]! - skill.requiredEnergy[Energy.UNIQUE]!;
      myEnergy.value[Energy.UNIQUE] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.WILLPOWER)) {
      int res = myEnergy.value[Energy.WILLPOWER]! -
          skill.requiredEnergy[Energy.WILLPOWER]!;
      myEnergy.value[Energy.WILLPOWER] = res;
    }
    focus.clearFocus();
    update();
  }

  void returnEnergy(Skill skill) {
    if (skill.requiredEnergy.containsKey(Energy.ARCANE)) {
      int res =
          myEnergy.value[Energy.ARCANE]! + skill.requiredEnergy[Energy.ARCANE]!;
      myEnergy.value[Energy.ARCANE] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.PHYSICAL)) {
      int res = myEnergy.value[Energy.PHYSICAL]! +
          skill.requiredEnergy[Energy.PHYSICAL]!;
      myEnergy.value[Energy.PHYSICAL] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.UNIQUE)) {
      int res =
          myEnergy.value[Energy.UNIQUE]! + skill.requiredEnergy[Energy.UNIQUE]!;
      myEnergy.value[Energy.UNIQUE] = res;
    }

    if (skill.requiredEnergy.containsKey(Energy.WILLPOWER)) {
      int res = myEnergy.value[Energy.WILLPOWER]! +
          skill.requiredEnergy[Energy.WILLPOWER]!;
      myEnergy.value[Energy.WILLPOWER] = res;
    }
    update();
  }

  void startTimerBliking(RxBool target) {
    _timer_bliking?.cancel();
    _timer_bliking = Timer.periodic(Duration(milliseconds: 800), (Timer timer) {
      target.value = !target.value;
      update();
    });
  }

  void stopTimerBlinking() {
    enemyClicable.value = false;
    allyClicable.value = false;
    allClicable.value = false;
    meClicable.value = false;
    _timer_bliking?.cancel();
    chooseTargetEnemy.value = false;
    chooseTargetAlly.value = false;
    chooseTargetAll.value = false;
    chooseTargetMe.value = false;
    update();
  }

  void addRemoveHealsAnimated(CharInBattle target, bool plus, int val) {
    if (target.stats.health > 0) {
      for (var i = 0; i < val; i++) {
        Future.delayed(Duration(milliseconds: 70)).then((value) {
          if (plus) {
            if (target.stats.health < 30) {
              target.stats.health++;
            }
          } else {
            if (target.stats.health > 0) {
              target.stats.health--;
            }
          }
          update();
        });
      }
    }
  }

  void subtractRandomEnergy(Energy energyType) {
  if (myEnergy.value.containsKey(energyType)) {
    int currentEnergy = myEnergy.value[energyType] ?? 0;
    if (currentEnergy > 0) {
      myEnergy.value[energyType] = currentEnergy - 1;

      int currentRandomGive = randomIGive.value[energyType] ?? 0;
      randomIGive.value[energyType] = currentRandomGive + 1;
    }
  }
  update();
}

void returnRandomEnergy(Energy energyType) {
  if (myEnergy.value.containsKey(energyType)) {
    int currentEnergy = myEnergy.value[energyType] ?? 0;
    int currentRandomGive = randomIGive.value[energyType] ?? 0;

    if (currentRandomGive > 0) {
      myEnergy.value[energyType] = currentEnergy + 1;
      randomIGive.value[energyType] = currentRandomGive - 1;
    }
  }
  update();
}

  void transferEnergyBack() {
  myEnergy.value.forEach((energy, value) {
    myEnergy.value[energy] = value + randomIGive.value[energy]!;
    randomIGive.value[energy] = 0;
  });
}
  
}

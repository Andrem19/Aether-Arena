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
  String enemy_role = 'B';
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final MainGameController _mainContr = Get.find<MainGameController>();
  AccountPlayerData my_accData = AccountPlayerData.empty();
  AccountPlayerData enemy_accData = AccountPlayerData.empty();
  Rx<Map<Energy, int>> myEnergy = Rx<Map<Energy, int>>({
    Energy.ARCANE: 2,
    Energy.PHYSICAL: 0,
    Energy.UNIQUE: 0,
    Energy.WILLPOWER: 1,
    Energy.RANDOM: 0,
  });
  RxBool chooseTarget = false.obs;
  Move my_move = Move.empty();
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
    await _setUpVars();
    _startListener();
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

  Future<void> _setUpVars() async {
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

  // void saveMove() async {
  //   my_move.moveNumber++;
  //   await _firebaseFirestore.collection('battles').doc(currentGameId).update({
  //     'GameInfo_$myRole': my_move.toJson(),
  //   });
  //   my_move.toEmpty();
  // }

  // void loadMove() async {
  //   var doc =
  //       await _firebaseFirestore.collection('battles').doc(currentGameId).get();
  //   var data = doc.data();
  //   enemy_move = Move.fromJson(data!['GameInfo_$enemy_role']);
  //   print(enemy_move);
  // }

  void applyMyMove() {
    if (my_move.isNew == true) {
      Skill skill_1 =
          BattleFunc.getAttackSkill(my_char_1.value, enemy_move.char_1.skillId);
      BattleFunc.addEffects(skill_1);
      Skill skill_2 =
          BattleFunc.getAttackSkill(my_char_2.value, enemy_move.char_2.skillId);
      BattleFunc.addEffects(skill_2);
      Skill skill_3 =
          BattleFunc.getAttackSkill(my_char_3.value, enemy_move.char_3.skillId);
      BattleFunc.addEffects(skill_3);
    }
  }

  void setCharFocus(int id) {
    focus.setUpChar(id);
  }

  void setSkillFocus(Skill skill) {
    focus.setUpSkill(_mainContr.characters, skill);
  }

  void setTarget(int targetId) {
    focus.setUpTarget_id(targetId);
    passFocusToTheMove();
  }

  void clearFocus() {
    focus.clearFocus();
  }

  void passFocusToTheMove() {
    if (focus.myCharId == my_char_1.value.id) {
      my_move.char_1.skillId = focus.skill_id;
      my_move.char_1.target = focus.target;
      my_move.char_1.ifOneWho = focus.target_idIfOne;
      my_move.char_1.empty = false;
      my_move.isNew = true;
    } else if (focus.myCharId == my_char_2.value.id) {
      my_move.char_2.skillId = focus.skill_id;
      my_move.char_2.target = focus.target;
      my_move.char_2.ifOneWho = focus.target_idIfOne;
      my_move.char_2.empty = false;
      my_move.isNew = true;
    } else if (focus.myCharId == my_char_3.value.id) {
      my_move.char_3.skillId = focus.skill_id;
      my_move.char_3.target = focus.target;
      my_move.char_3.ifOneWho = focus.target_idIfOne;
      my_move.char_3.empty = false;
      my_move.isNew = true;
    }
    focus.clearFocus();
  }

  void startTimerBliking() {
    _timer_bliking?.cancel();
    _timer_bliking = Timer.periodic(Duration(milliseconds: 800), (Timer timer) {
      chooseTarget.value = !chooseTarget.value;
      update();
    });
  }

  void stopTimerBlinking() {
    _timer_bliking?.cancel();
    chooseTarget.value = false;
    update();
  }
}

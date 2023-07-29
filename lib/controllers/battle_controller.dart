import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/models/char_in_battle.dart';

import '../models/account_player_data.dart';
import '../models/enums.dart';
import '../models/focus.dart';
import '../models/move.dart';
import 'main_game_controller.dart';

class BattleController extends GetxController {
  int timeOfMove = 21;
  RxString infoText = ''.obs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final MainGameController _mainContr = Get.find<MainGameController>();
  AccountPlayerData my_accData = AccountPlayerData.empty();
  AccountPlayerData enemy_accData = AccountPlayerData.empty();
  Move my_move = Move.empty();
  Move enemy_move = Move.empty();
  Focus focus = Focus.empty();

  List<CharInBattle> my_set = [
    CharInBattle.empty(),
    CharInBattle.empty(),
    CharInBattle.empty(),
  ];
  List<CharInBattle> enemy_set = [
    CharInBattle.empty(),
    CharInBattle.empty(),
    CharInBattle.empty(),
  ];

  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _listener;
  Timer? _timer;

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
    super.onClose();
  }

  Future<void> _setUpVars() async {
    myRole = _mainContr.curentRole;
    final doc = await _firebaseFirestore
        .collection('battles')
        .doc(_mainContr.curentGameId)
        .get();
    final data = doc.data();
    whoIsMove.value = data!['WhosMove'];
    currentGameId = _mainContr.curentGameId;
    var A_set = [
      CharInBattle.fromJson(data['playerA_char_1']),
      CharInBattle.fromJson(data['playerA_char_2']),
      CharInBattle.fromJson(data['playerA_char_3'])
    ];
    var B_set = [
      CharInBattle.fromJson(data['playerB_char_1']),
      CharInBattle.fromJson(data['playerB_char_2']),
      CharInBattle.fromJson(data['playerB_char_3'])
    ];
    my_accData = myRole == 'A'
        ? AccountPlayerData.fromJson(data['PlayerA_accData'])
        : AccountPlayerData.fromJson(data['PlayerB_accData']);
    enemy_accData = myRole == 'A'
        ? AccountPlayerData.fromJson(data['PlayerB_accData'])
        : AccountPlayerData.fromJson(data['PlayerA_accData']);
    my_set = myRole == 'A' ? A_set : B_set;
    enemy_set = myRole == 'A' ? B_set : A_set;

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
        if (whoIsMove.value == myRole && _timer == null) {
          timerValue.value = timeOfMove;
          loadMove();
          _startTimerMove();
        }
        if (whoIsMove.value != myRole) {
          timerValue.value = timeOfMove;
          _timer?.cancel();
          _timer = null;
        }
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
        saveMove();
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

  void saveMove() async {
    my_move.moveNumber++;
    await _firebaseFirestore
        .collection('battles')
        .doc(currentGameId)
        .update({'GameInfo_$myRole': my_move.toJson()});
  }

  void loadMove() async {
    String enemy_role = myRole == 'A' ? 'B' : 'A';
    var doc =
        await _firebaseFirestore.collection('battles').doc(currentGameId).get();
    var data = doc.data();
    enemy_move = Move.fromJson(data!['GameInfo_$enemy_role']);
    print(enemy_move.moveNumber);
  }

  void setCharFocus(int id) {
    focus.setUpChar(id);
  }

  void setSkillFocus(int id) {
    focus.setUpSkill(_mainContr.characters, id);
  }

  void setTarget(int id, Target target) {
    focus.setUpTarget(id, target);
    passFocusToTheMove();
  }

  void passFocusToTheMove() {}
}

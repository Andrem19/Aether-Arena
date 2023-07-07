import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'main_game_controller.dart';

class BattleController extends GetxController {
  static const int timeOfMove = 20;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final MainGameController _mainContr = Get.find<MainGameController>();
  
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _listener;
  Timer? _timer;
  
  final RxInt timerValue = timeOfMove.obs;
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
    final doc = await _firebaseFirestore
        .collection('battles')
        .doc(_mainContr.curentGameId)
        .get();
    final data = doc.data();
    whoIsMove.value = data!['WhosMove'];
    currentGameId = _mainContr.curentGameId;
    myRole = _mainContr.curentRole;
    timerValue.value = timeOfMove;
    if (whoIsMove.value == myRole) {
      _startTimerMove();
    }
  }

  void _startListener() {
    final snapshots = _firebaseFirestore
        .collection('battles')
        .doc(currentGameId)
        .snapshots();
    _listener = snapshots.listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        whoIsMove.value = data!['WhosMove'];
        if (whoIsMove.value == myRole && _timer == null) {
          timerValue.value = timeOfMove;
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
}
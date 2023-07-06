import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'main_game_controller.dart';

class BattleController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MainGameController mainContr = Get.find<MainGameController>();
  late Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listner;
  Timer? _timer;
  RxInt timerValue = 0.obs;
  RxString WhosMove = ''.obs;
  String currentGameId = '';
  String myRole = '';

  @override
  void onInit() async {
    await setUpVars();
    startListner();
    super.onInit();
  }

  @override
  void onClose() {
    updatePlayer_ready();
    mainContr.deleteGameInstant();
    super.onClose();
  }

  Future<void> setUpVars() async {
    var doc = await firebaseFirestore
        .collection('battles')
        .doc(mainContr.curentGameId)
        .get();
    var data = doc.data();
    WhosMove.value = data!['WhosMove'];
    currentGameId = mainContr.curentGameId;
    myRole = mainContr.curentRole;
    timerValue.value = myRole == WhosMove.value ? 20 : 0;
    if (WhosMove.value == myRole) {
      startTimerMove();
    }
  }

  void startListner() {
    snapshots = FirebaseFirestore.instance
        .collection('battles')
        .doc(currentGameId)
        .snapshots();
    listner = snapshots.listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        WhosMove.value = data!['WhosMove'];
        if (WhosMove.value == myRole && timerValue.value == 0) {
          timerValue.value = 20;
          startTimerMove();
        }
      }
    });
  }

  void updatePlayer_ready() async {
    await firebaseFirestore.collection('battles').doc(currentGameId).update({
      'Player${myRole}_ready': false,
    });
  }

  void startTimerMove() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timerValue.value < 0) {
        timerValue.value = 20;
      }
      timerValue.value--;
      print(timerValue.value);
      if (timerValue == 1) {
        setUpNxtMove();
        timerValue.value = 0;
        _timer?.cancel();
      }
    });
  }

  void setUpNxtMove() async {
    await firebaseFirestore.collection('battles').doc(currentGameId).update({
      'WhosMove': myRole == 'A' ? 'B' : 'A',
    });
  }
}

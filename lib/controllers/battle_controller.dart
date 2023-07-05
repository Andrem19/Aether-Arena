import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'main_game_controller.dart';

class BattleController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MainGameController mainContr = Get.find<MainGameController>();
  String currentGameId = '';
  String myRole = '';

  @override
  void onInit() {
    currentGameId = mainContr.curentGameId;
    myRole = mainContr.curentRole;
    super.onInit();
  }

  @override
  void onClose() {
    updatePlayer_ready();
    mainContr.deleteGameInstant();
    super.onClose();
  }

  void updatePlayer_ready() async {
    await firebaseFirestore.collection('battles').doc(currentGameId).update({
      'Player${myRole}_ready': false,
    });
  }
}

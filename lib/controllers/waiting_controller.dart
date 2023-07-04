import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/char_in_battle.dart';

class WaitingController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Uuid uuid = Uuid();

  Future<void> createGameInstant() async {
    await firebaseFirestore.collection('battles').add({
      'game_id': uuid.v4(),
      'PlayerA_uid': '',
      'PlayerB_uid': '',
      'status': 'waiting',
      'playerA_char_1': CharInBattle.empty().toJson(),
      'playerA_char_2': CharInBattle.empty().toJson(),
      'playerA_char_3': CharInBattle.empty().toJson(),
      'playerB_char_1': CharInBattle.empty().toJson(),
      'playerB_char_2': CharInBattle.empty().toJson(),
      'playerB_char_3': CharInBattle.empty().toJson(),
    });
  }
  void startStream() {
    
  }
}

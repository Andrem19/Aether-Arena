import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/models/account_player_data.dart';
import 'package:the_test_naruto_arena/models/enum_serializer.dart';
import 'package:uuid/uuid.dart';

import '../keys.dart';
import '../models/char_in_battle.dart';
import 'main_game_controller.dart';
import 'routing/app_pages.dart';

class WaitingController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MainGameController mainContr = Get.find<MainGameController>();
  late Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listner;
  RxString gameStatus = 'searching...'.obs;
  RxString randomAdvice =
      'Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, Some Advice, '
          .obs;
  Timer? _timer;
  Uuid uuid = Uuid();

  @override
  void onInit() async {
    await Future.delayed(Duration(seconds: 3), () {});
    if (mainContr.gameType == GameType.PrivateBattle) {
      if (mainContr.curentRole == 'A') {
        await _addPlayerToList(mainContr.gameType);

        await firebaseFirestore
            .collection('meetPoint')
            .doc(mainContr.playerWhoIInvite_ID)
            .update({
          'isAnybodyAscMe': true,
          'whoInviteMeToPlay': mainContr.userProfile.value.userName,
          'theGameIdInviteMe': mainContr.curentGameId
        });
      } else if (mainContr.curentRole == 'B') {
        Get.offNamed(Routes.INITIAL);
      }
    } else {
      _adPlayerToQueueOrFindRival();
    }
    super.onInit();
  }

  @override
  void onClose() {
    listner?.cancel();
    _timer?.cancel();
    mainContr.deleteGameInstant();
    super.onClose();
  }

  Future<String> getRandomAdvice() async {
    return '';
  }

  void _adPlayerToQueueOrFindRival() async {
    await mainContr.deleteAllMyGamesIfExist();
    int currentDate = Timestamp.now().seconds;
    var playerList = await FirebaseFirestore.instance
        .collection('battles')
        .where('status', isEqualTo: 'searching')
        .where('game_type', isEqualTo: mainContr.gameType.name)
        .where('date', isGreaterThan: currentDate - 29)
        .get();
    if (playerList.docs.isEmpty) {
      _addPlayerToList(mainContr.gameType);
    } else {
      var accData = AccountPlayerData(
        name: mainContr.userProfile.value.userName,
        avatar: mainContr.userProfile.value.avatar,
        rank: mainContr.getRank(),
        level: mainContr.getLevel()['level']!);
      await FirebaseFirestore.instance
          .collection('battles')
          .doc(playerList.docs[0].id)
          .update({
        'PlayerB_uid': mainContr.userProfile.value.uid,
        'PlayerB_Name': mainContr.userProfile.value.userName,
        'PlayerB_accData': accData.toJson(),
        'PlayerB_ready': true,
        'playerB_char_1': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[0])
            .toJson(),
        'playerB_char_2': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[1])
            .toJson(),
        'playerB_char_3': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[2])
            .toJson(),
        'status': 'game'
      });
      var data = playerList.docs[0].data();
      mainContr.curentGameId = playerList.docs[0].id;
      mainContr.curentRole = 'B';
      Get.offNamed(Routes.BATTLE_ACT);
    }
  }

  Future<void> _addPlayerToList(GameType type) async {
    int whoseMove = Random().nextInt(2);
    var accData = AccountPlayerData(
        name: mainContr.userProfile.value.userName,
        avatar: mainContr.userProfile.value.avatar,
        rank: mainContr.getRank(),
        level: mainContr.getLevel()['level']!);
    try {
      var doc = await firebaseFirestore.collection('battles').add({
        'game_id': mainContr.curentGameId,
        'game_type': EnumSerializer.GameTypetoString(mainContr.gameType),
        'PlayerA_uid': '',
        'PlayerB_uid': '',
        'PlayerA_accData': accData.toJson(),
        'PlayerB_accData': '',
        'status': 'searching',
        'IcantPlay': false,
        'PlayerA_ready': false,
        'PlayerB_ready': false,
        'WhosMove': whoseMove == 0 ? 'A' : 'B',
        'playerA_char_1': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[0])
            .toJson(),
        'playerA_char_2': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[1])
            .toJson(),
        'playerA_char_3': mainContr
            .getCharacterFromId(mainContr.userProfile.value.mySet[2])
            .toJson(),
        'playerB_char_1': CharInBattle.empty().toJson(),
        'playerB_char_2': CharInBattle.empty().toJson(),
        'playerB_char_3': CharInBattle.empty().toJson(),
        'GameInfo_A': '',
        'GameInfo_B': '',
        'date': Timestamp.now().seconds,
      });
      mainContr.curentRole = 'A';
      mainContr.curentGameId = doc.id;
      await firebaseFirestore.collection('battles').doc(doc.id).update({
        'game_id': mainContr.curentGameId,
      });
      startTimerGameAlive(doc.id);
      startGameStream(doc.id);
    } on FirebaseException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text('1${error.toString()}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void startTimerGameAlive(String id) {
    _timer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      firebaseFirestore.collection('battles').doc(id).update({
        'date': Timestamp.now().seconds,
      });
    });
  }

  void startGameStream(String id) async {
    snapshots =
        FirebaseFirestore.instance.collection('battles').doc(id).snapshots();
    listner = snapshots.listen((snapshot) {
      if (snapshot.exists) {
        var data = snapshot.data();
        gameStatus.value = data!['status'];
        bool IcantPlay = data['IcantPlay'];
        if (IcantPlay) {
          listner?.cancel();
          mainContr.changeStatusInGame(false);
          firebaseFirestore
              .collection('battles')
              .doc(mainContr.curentGameId)
              .delete();
          Get.offNamed(Routes.PLAY_MENU);
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
            content: Text('Player refuses to play'),
            backgroundColor: Colors.red,
          ));
        }
        if (gameStatus.value == 'game') {
          updatePlayerA_ready();
          Get.offNamed(Routes.BATTLE_ACT);
        }
      } else {
        print('Document does not exist');
      }
    });
    update();
  }

  void updatePlayerA_ready() async {
    await firebaseFirestore
        .collection('battles')
        .doc(mainContr.curentGameId)
        .update({
      'PlayerA_ready': true,
    });
  }
}

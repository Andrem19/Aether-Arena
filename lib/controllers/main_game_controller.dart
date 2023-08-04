import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/data/struct.dart';
import 'package:the_test_naruto_arena/models/char_in_battle.dart';
import 'package:the_test_naruto_arena/models/history_battle.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../data/characters.dart';
import '../keys.dart';
import '../models/skill.dart';
import '../models/user.dart';
import '../widgets/custom_text_field.dart';
import 'routing/app_pages.dart';

class MainGameController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listner;
  Uuid uuid = Uuid();
  Rx<UserProfile> userProfile = UserProfile.getEmpty().obs;
  RxList<HistoryBattle> historyOfMyBattle = <HistoryBattle>[].obs;
  late AuthProviderController _authProviderController;
  TextEditingController namePrivateBattle = TextEditingController();
  RxInt curentlevel = 0.obs;
  GameType gameType = GameType.QuickBattle;
  String curentGameId = '';
  String curentRole = 'A';
  String playerWhoIInvite_ID = '';
  List<CharInBattle> characters = [];
  @override
  void onInit() async {
    characters = await GetStruct.deserializeJsonToList(Chars.chars);
    // print(characters.length);
    // for (var i = 0; i < characters.length; i++) {
    //   print(characters[i].id);
    //   print(characters[i].name);
    //   print(characters[i].condition);
    //   for (var j = 0; j < characters[i].allSkills.length; j++) {
    //     print(characters[i].allSkills[j].id);
    //     print(characters[i].allSkills[j].name);
    //     for (var p = 0; p < characters[i].allSkills[j].effects.length; p++) {
    //       print(characters[i].allSkills[j].effects[p].id);
    //     }
    //   }
    // }
    for (var i = 0; i < 15; i++) {
      CharInBattle char = characters[i];
      characters.add(char);
    }
    _authProviderController.firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        // User is authenticated, set up the listener if it is null
        if (listner == null) {
          setUpListner(user.uid);
        }
      } else {
        // User is not authenticated, remove the listener if it is not null
        if (listner != null) {
          listner!.cancel();
          listner = null;
        }
      }
    });
    super.onInit();
  }

  void changeName(String uid) async {
    await firebaseFirestore.collection('users').doc(uid).update({
      'userName': 'NewName',
    });
  }

  void initialize(AuthProviderController authProviderController) {
    _authProviderController = authProviderController;
  }

  void showCardDialog(BuildContext context, CharInBattle character) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Name'),
          content: SingleChildScrollView(
            child: Container(
              width: Get.width / 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Get.height / 5,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      children: List.generate(
                        character.allSkills.length,
                        (index) => GestureDetector(
                          onTapDown: (_) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  content: Text(
                                    'Skill description Skill description Skill description Skill description',
                                    maxLines: 10,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                );
                              },
                            );
                          },
                          onTapUp: (_) {
                            Navigator.of(context).pop();
                          },
                          child: Card(
                            child: Container(
                              width: Get.width / 8,
                              height: Get.width / 8,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                  getSkillImage(character.allSkills[index])),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    child: SizedBox(
                      width: Get.width / 2,
                      child: Text(
                        'some describing text some describing text some describing text some describing text some describing text',
                        maxLines: 10,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  CharInBattle getCharacterFromId(int id) {
    return characters.firstWhere((element) => element.id == id,
        orElse: () => characters[0]);
  }

  String getCharacterImageFromId(int id) {
    if (id != 0) {
      return characters
          .firstWhere((element) => element.id == id,
              orElse: () => characters[0])
          .img;
    } else {
      return 'assets/none_char.png';
    }
  }

  Future<File?> pickImageFromGallery() async {
    FilePickerResult? pickedImage =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (pickedImage != null) {
      return File(pickedImage.files.single.path!);
    } else {
      return null;
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('avatars/${userProfile.value.email}.jpg');
      firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      firebaseFirestore.collection('users').doc(userProfile.value.uid).update({
        'avatar': downloadUrl,
      });
      userProfile.value.avatar = downloadUrl;
      update();

      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void infoBoardMySetOnAccept(int index, CharInBattle data) async {
    if (userProfile.value.mySet.contains(data.id)) {
      return;
    }
    userProfile.value.mySet[index] = data.id;
    await firebaseFirestore.doc('users/${userProfile.value.uid}').update({
      'mySet': userProfile.value.mySet,
    });
    update();
  }

  void deleteCardFromMySet(int index) async {
    userProfile.value.mySet[index] = 0;
    await firebaseFirestore.doc('users/${userProfile.value.uid}').update({
      'mySet': userProfile.value.mySet,
    });
    update();
  }

  void addHistory(int index) async {
    String identificator = uuid.v4();
    HistoryBattle historyBattle = HistoryBattle.getEmptyHistoryBattle();
    historyBattle.identificator = identificator;
    firebaseFirestore.collection('history').doc(userProfile.value.uid).update({
      'myHistory': FieldValue.arrayUnion([historyBattle.toJson()]),
    });
  }

  String getRank() {
    var res = getLevel();
    int level = res['level']!;
    if (level > 0 && level <= 5) {
      return 'Porcelain';
    } else if (level > 5 && level <= 10) {
      return 'Obsidian';
    } else if (level > 10 && level <= 15) {
      return 'Steel';
    } else if (level > 15 && level <= 20) {
      return 'Sapphire';
    } else if (level > 20 && level <= 25) {
      return 'Emerald';
    } else if (level > 25 && level <= 30) {
      return 'Ruby';
    } else if (level > 30 && level <= 35) {
      return 'Bronze';
    } else if (level > 35 && level <= 40) {
      return 'Silver';
    } else if (level > 40 && level <= 45) {
      return 'Gold';
    } else if (level > 45) {
      return 'Platinum';
    } else {
      return 'Porcelain';
    }
  }

  Map<String, int> getLevel() {
    int kof = 100;
    int myExp = userProfile.value.expirience;
    int level = 1;
    while (myExp >= 0) {
      level++;
      myExp -= kof;
      kof += 25;
    }
    level -= 1;
    curentlevel.value = level;
    return {
      "level": level,
      "kof": kof,
      "myExp": kof - myExp.abs() - 25,
    };
  }

  String getSkillImage(Skill skill) {
    if (skill.img != '') {
      return skill.img;
    } else {
      return 'assets/default_skill.jpg';
    }
  }

  Future<void> getHistory() async {
    var doc = await firebaseFirestore
        .collection('history')
        .doc(userProfile.value.uid)
        .get();
    var data = doc.data();
    List<dynamic> myHistory = data!['myHistory'];
    List<String> listHist = List<String>.from(myHistory);
    for (var i = 0; i < listHist.length; i++) {
      historyOfMyBattle.add(HistoryBattle.fromJson(listHist[i]));
    }
    setCardsOpen();
  }

  void setCardsOpen() {
    for (var i = 0; i < characters.length; i++) {
      characters[i].isOpen = isCardOpen(characters[i]);
    }
  }

  bool isCardOpen(CharInBattle card) {
    if (card.condition != null) {
      if (curentlevel < card.condition!.RequiredLevel) {
        return false;
      }
      List<bool> res = [];
      for (var i = 0; i < card.condition!.winnConditions.length; i++) {
        bool shouldBeCont =
            card.condition!.winnConditions[i].ShouldBeContinuously;
        int numberOfWinRequired = card.condition!.winnConditions[i].count;
        int counter = 0;
        for (var j = 0; j < historyOfMyBattle.length; j++) {
          if (historyOfMyBattle[j].isIWinner &&
              compareLists(historyOfMyBattle[j].mySet,
                  card.condition!.winnConditions[i].mySet)) {
            counter += 1;
            if (counter >= numberOfWinRequired) {
              res.add(true);
              break;
            }
          } else if (shouldBeCont) {
            counter = 0;
          }
        }
      }
      if (res.length >= card.condition!.winnConditions.length &&
          res.every((element) => true)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  bool compareLists(List<int> list1, List<int> list2) {
    return Set<int>.from(list1).containsAll(list2) &&
        Set<int>.from(list2).containsAll(list1);
  }

  void privateBattleDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Enter name'),
            content: CustomTextField(
              iconData: Icons.person,
              hintText: 'Enter name',
              controller: namePrivateBattle,
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context).pop();
                    try {} catch (error) {
                      Keys.scaffoldMessengerKey.currentState!
                          .showSnackBar(SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red,
                      ));
                      navigator;
                    }
                  },
                  child: const Text('Invite To Play'))
            ],
          );
        });
  }

  void deleteGameInstant() async {
    var doc =
        await firebaseFirestore.collection('battles').doc(curentGameId).get();
    if (doc.exists) {
      var data = doc.data();
      bool Player_A = data!['PlayerA_ready'];
      bool Player_B = data['PlayerB_ready'];
      if (!Player_A && !Player_B) {
        await firebaseFirestore
            .collection('battles')
            .doc(curentGameId)
            .delete();
      }
    }
  }

  Future<void> setUpListner(String uid) async {
    snapshots =
        FirebaseFirestore.instance.collection('meetPoint').doc(uid).snapshots();
    listner = snapshots.listen((data) {
      bool isAnybodyAscMe = data['isAnybodyAscMe'];
      String whoAskMe = data['whoInviteMeToPlay'];
      String theGameIdInviteMe = data['theGameIdInviteMe'];
      if (isAnybodyAscMe) {
        firebaseFirestore.collection('meetPoint').doc(uid).update({
          'isAnybodyAscMe': false,
        });
        changeStatusInGame(true);
        Get.dialog(AlertDialog(
            title: Text('$whoAskMe invite your to the game'),
            content: const Text('Do you want to play?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    textStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  changeStatusInGame(false);
                  firebaseFirestore
                      .collection('battles')
                      .doc(theGameIdInviteMe)
                      .update({
                    'IcantPlay': true,
                  });
                  Get.back();
                },
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {
                  agreeToPlayPreparing(theGameIdInviteMe);
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ]));
      }
    });
  }

  bool checkAndSayIfNotFullSet() {
    if (userProfile.value.mySet[0] != 0 &&
        userProfile.value.mySet[1] != 0 &&
        userProfile.value.mySet[2] != 0) {
      return true;
    } else {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text('You must select a full set to play.'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  Future<void> agreeToPlayPreparing(String theGameIdInviteMe) async {
    if (!checkAndSayIfNotFullSet()) {
      return;
    }
    await deleteAllMyGamesIfExist();
    try {
      firebaseFirestore.collection('battles').doc(theGameIdInviteMe).update({
        'Player_B_uid': userProfile.value.uid,
        'PlayerB_Name': userProfile.value.userName,
        'gameStatus': 'game'
      });
      var doc = await firebaseFirestore
          .collection('battles')
          .doc(theGameIdInviteMe)
          .get();

      curentGameId = theGameIdInviteMe;
      curentRole = 'B';

      Get.toNamed(Routes.BATTLE_ACT);
    } on FirebaseException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  void changeStatusInGame(bool status) async {
    await firebaseFirestore
        .collection('users')
        .doc(userProfile.value.uid)
        .update({
      'isUserInGame': status,
    });
  }

  Future<void> deleteAllMyGamesIfExist() async {
    var gameList_A = await firebaseFirestore
        .collection('battles')
        .where('PlayerA_uid', isEqualTo: userProfile.value.uid)
        .get();
    if (gameList_A.docs.length > 0) {
      for (var i = 0; i < gameList_A.docs.length; i++) {
        await firebaseFirestore
            .collection('battles')
            .doc(gameList_A.docs[i].id)
            .delete();
      }
    }

    var gameList_B = await firebaseFirestore
        .collection('battles')
        .where('PlayerB_uid', isEqualTo: userProfile.value.uid)
        .get();
    if (gameList_B.docs.length > 0) {
      for (var i = 0; i < gameList_B.docs.length; i++) {
        await firebaseFirestore
            .collection('battles')
            .doc(gameList_B.docs[i].id)
            .delete();
      }
    }
  }

  void changeWantToPlay() async {
    await firebaseFirestore
        .collection('users')
        .doc(userProfile.value.uid)
        .update({
      'wantToPlay': userProfile.value.wantToPlay,
    });
    if (userProfile.value.wantToPlay) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content:
            Text('You have allowed other players to invite you to the game'),
        backgroundColor: Colors.green,
      ));
    } else {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(
            'You have blocked other players from inviting you to the game'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void invitePlayerForBattle() async {
    await deleteAllMyGamesIfExist();

    var doc = await firebaseFirestore
        .collection('users')
        .where('name', isEqualTo: namePrivateBattle.text)
        .get();
    if (doc.docs.length > 0) {
      var data = doc.docs[0].data();
      bool status = data['isUserInGame'] as bool;
      bool alowed = data['wantToPlay'] as bool;
      if (alowed) {
        if (status) {
          Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
            content: Text('This user currently playing another game'),
            backgroundColor: Colors.red,
          ));
          return;
        }
        changeStatusInGame(true);
        curentRole = 'A';
        playerWhoIInvite_ID = doc.docs[0].id; //????

        Get.toNamed(Routes.WAITING_PAGE);
        namePrivateBattle.clear();
      } else if (!alowed) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text('Player has disabled game invites'),
          backgroundColor: Colors.red,
        ));
        return;
      }
    }
  }
}

enum GameType { LadderBattle, QuickBattle, PrivateBattle }

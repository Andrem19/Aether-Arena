import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';
import '../keys.dart';
import 'main_game_controller.dart';

class SettingsController extends GetxController {
  AuthProviderController authCtrl = Get.find<AuthProviderController>();
  MainGameController mainCtrl = Get.find<MainGameController>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController userNameController = TextEditingController();

  @override
  void onInit() async {
    userNameController.text = mainCtrl.userProfile.value.userName;
    update();
    super.onInit();
  }

  Future<void> updateName() async {
    String normalizedName =
        userNameController.value.text.replaceAll(RegExp(r'\s+'), '');
    bool res = await authCtrl.chekNameExist(normalizedName);
    bool res2 = checkNickChangeAllowd();
    if (res || !res2) {
      return;
    }
    try {
      int time = Timestamp.now().seconds;
      mainCtrl.userProfile.value.nickWasChanged = time;
      mainCtrl.userProfile.value.userName = normalizedName;

      await firebaseFirestore
          .collection('users')
          .doc(mainCtrl.userProfile.value.uid)
          .update({
        'userName': normalizedName,
        'nickWasChanged': time,
      });
      update();
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text('Name updated'),
        backgroundColor: Color.fromARGB(255, 54, 244, 67),
      ));
      Get.offNamed(Routes.INITIAL);
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

  bool checkNickChangeAllowd() {
    int timestamp = Timestamp.now().seconds - 604800;
    bool res = mainCtrl.userProfile.value.nickWasChanged < timestamp;
    if (!res) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text(
            'You need to wait one week before you can change your nickname again'),
        backgroundColor: Colors.red,
      ));
    }
    return res;
  }
}

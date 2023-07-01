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
    if (res) {
      return;
    }
    try {
      mainCtrl.userProfile.value.userName = normalizedName;
      var user = await firebaseFirestore
          .collection('users')
          .doc(mainCtrl.userProfile.value.uid)
          .get();
      if (user.exists) {
        await firebaseFirestore
            .collection('users')
            .doc(mainCtrl.userProfile.value.uid)
            .update({
          'userName': normalizedName,
        });
        update();
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text('Name updated'),
          backgroundColor: Color.fromARGB(255, 54, 244, 67),
        ));
        Get.offNamed(Routes.INITIAL);
      } else {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text('User doesnt exist'),
          backgroundColor: Colors.red,
        ));
      }
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
}

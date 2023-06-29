import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MainGameController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void changeName(String uid) async {
    await firebaseFirestore.collection('users').doc(uid).update({
      'userName': 'NewName',
    });
  }
}

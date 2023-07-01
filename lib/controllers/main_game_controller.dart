import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/services/read_desrialize_json.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

import '../models/character.dart';
import '../models/user.dart';

class MainGameController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Rx<UserProfile> userProfile = UserProfile.getEmpty().obs;
  late AuthProviderController _authProviderController;
  List<Character> characters = [];
  @override
  void onInit() async {
    characters = await ReadJson.readCharactersFromFile();
    for (var i = 0; i < 21; i++) {
      Character char = characters[i];
      characters.add(char);
    }
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

  void showCardDialog(BuildContext context) {
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
                        8,
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
                              child: Icon(Icons.abc),
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

  bool isThisCardOpen(String name) {
    if (userProfile.value.openCards.contains(name)) {
      return true;
    } else {
      return false;
    }
  }

  Character getCharFromName(String name) {
    return characters.firstWhere((element) => element.name == name,
        orElse: () => characters[0]);
  }

  Future<File?> pickImageFromGallery() async {
  FilePickerResult? pickedImage = await FilePicker.platform.pickFiles(type: FileType.image);

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
}

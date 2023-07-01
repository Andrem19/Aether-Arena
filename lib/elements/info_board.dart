import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';

class InfoBoard extends StatelessWidget {
  const InfoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviderController authCtrl = Get.find<AuthProviderController>();
    return GetBuilder<MainGameController>(builder: (controller) {
      return Container(
        height: Get.height / 2.5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Navigator.canPop(context)
                    ? IconButton(
                        onPressed: () async {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      )
                    : const SizedBox(
                        width: 25,
                      ),
                Text(
                  controller.userProfile.value.userName,
                  style: TextStyle(fontSize: 25),
                ),
                IconButton(
                    onPressed: () {
                      authCtrl.logOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: controller.userProfile.value.avatar == ''
                        ? Image.asset(
                            'assets/default_avatar.jpg',
                            width: Get.width / 4,
                          )
                        : Image.network(
                            controller.userProfile.value.avatar,
                            width: Get.width / 4,
                          ),
                  ),
                  Positioned(
                      right: 12,
                      bottom: 12,
                      child: InkWell(
                        onTap: () async {
                          File? imageFile =
                              await controller.pickImageFromGallery();
                          if (imageFile != null) {
                            String? downloadUrl = await controller
                                .uploadImageToFirebaseStorage(imageFile);
                            print('Download URL: $downloadUrl');
                          }
                        },
                        child: Icon(
                          Icons.photo_camera,
                          color: Colors.black,
                        ),
                      ))
                ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Level: 1')],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  3,
                  (index) => Card(
                        child: controller.userProfile.value.mySet.isNotEmpty
                            ? Image.asset(
                                controller
                                    .getCharFromName(controller
                                        .userProfile.value.mySet[index])
                                    .img,
                                width: Get.width / 5,
                              )
                            : Image.asset(
                                'assets/none_char.png',
                                width: Get.width / 5,
                              ),
                      )),
            )
          ],
        ),
      );
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/elements/exp_line.dart';

import '../models/char_in_battle.dart';

class InfoBoard extends StatelessWidget {
  const InfoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviderController authCtrl = Get.find<AuthProviderController>();
    return GetBuilder<MainGameController>(builder: (controller) {
      return SafeArea(
        child: Container(
          height: Get.height * 0.37,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                              width: Get.height * 0.13,
                              height: Get.height * 0.13,
                            )
                          : Image.network(
                              controller.userProfile.value.avatar,
                              width: Get.height * 0.14,
                              height: Get.height * 0.14,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rank: ${controller.getRank()}', style: const TextStyle(fontSize: 20),),
                        Row(
                          children: [
                            const Text('Level: ', style: TextStyle(fontSize: 20),),
                            ExpLine.getExpLine(controller),
                          ],
                        ),
                        ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      3,
                      (index) => DragTarget<CharInBattle>(
                            onAccept: (data) {
                              print(controller.userProfile.value.mySet);
                              controller.infoBoardMySetOnAccept(index, data);
                            },
                            builder: (context, _, __) {
                              return InkWell(
                                onTap: () {
                                  controller.deleteCardFromMySet(index);
                                },
                                child: Card(
                                  child: Image.asset(
                                    controller.getCharacterImageFromId(controller
                                        .userProfile.value.mySet[index]),
                                    width: Get.height * 0.12,
                                  ),
                                ),
                              );
                            },
                          )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

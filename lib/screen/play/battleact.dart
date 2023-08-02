import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/elements/BattleMySkill.dart';
import 'package:the_test_naruto_arena/elements/avatarinthebattle.dart';
import 'package:the_test_naruto_arena/elements/choosenskill.dart';
import 'package:the_test_naruto_arena/elements/energybattle.dart';
import 'package:the_test_naruto_arena/elements/infopanelBattle.dart';
import 'package:the_test_naruto_arena/elements/nameinbattle.dart';
import 'package:the_test_naruto_arena/elements/charinbattle.dart';
import 'package:the_test_naruto_arena/elements/shell.dart';
import 'package:the_test_naruto_arena/elements/skillwhileattached.dart';
import 'package:the_test_naruto_arena/widgets/move_button.dart';

class BattleAct extends StatelessWidget {
  const BattleAct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(initState: (state) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
    }, dispose: (state) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }, builder: (controller) {
      double width = kIsWeb ? Get.width / 3 : Get.width;
      return Shell(
          content: Center(
        child: Container(
          width: kIsWeb ? Get.width / 3 : Get.width,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.30,
                child: Column(
                  children: [
                    BattleName.getName(controller.enemy_accData.name),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarInTheBattle.getAvatar(controller.enemy_accData, width),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInTheBattle.getChar(true,
                                        controller.enemy_char_1.value, width),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill(width)))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInTheBattle.getChar(true,
                                        controller.enemy_char_2.value, width),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill(width)))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInTheBattle.getChar(true,
                                        controller.enemy_char_3.value, width),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill(width)))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BattleName.getName(controller.my_accData.name),
                            AvatarInTheBattle.getAvatar(controller.my_accData, width),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) => SkillWhileAtached
                                                    .getSkill(width))),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill(1,controller
                                                .my_char_1.value
                                                .getSkill(4), width),
                                            BattleMySkill.getMySkill(1,controller
                                                .my_char_1.value
                                                .getSkill(3), width),
                                            BattleMySkill.getMySkill(1,controller
                                                .my_char_1.value
                                                .getSkill(2), width),
                                            BattleMySkill.getMySkill(1,controller
                                                .my_char_1.value
                                                .getSkill(1), width),
                                            ChoosenSkill.getChoosenSkill(
                                                1, width)
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInTheBattle.getChar(false,
                                        controller.my_char_1.value, width),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) => SkillWhileAtached
                                                    .getSkill(width))),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill(2,controller
                                                .my_char_2.value
                                                .getSkill(4), width),
                                            BattleMySkill.getMySkill(2,controller
                                                .my_char_2.value
                                                .getSkill(3), width),
                                            BattleMySkill.getMySkill(2,controller
                                                .my_char_2.value
                                                .getSkill(2), width),
                                            BattleMySkill.getMySkill(2,controller
                                                .my_char_2.value
                                                .getSkill(1), width),
                                            ChoosenSkill.getChoosenSkill(
                                                2, width)
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInTheBattle.getChar(false,
                                        controller.my_char_2.value, width),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) => SkillWhileAtached
                                                    .getSkill(width))),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill(3,controller
                                                .my_char_3.value
                                                .getSkill(4), width),
                                            BattleMySkill.getMySkill(3,controller
                                                .my_char_3.value
                                                .getSkill(3), width),
                                            BattleMySkill.getMySkill(3,controller
                                                .my_char_3.value
                                                .getSkill(2), width),
                                            BattleMySkill.getMySkill(3,controller
                                                .my_char_3.value
                                                .getSkill(1), width),
                                            ChoosenSkill.getChoosenSkill(
                                                3, width)
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInTheBattle.getChar(false,
                                        controller.my_char_3.value, width),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    BattleInfoPanel.getPanel(width),
                    EnergyBattle.getEnergy(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoveButton(width: width),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ));
    });
  }
}

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
      return Scaffold(
          body: Center(
            child: Container(
              width: kIsWeb ? Get.width /3 : Get.width,
              child: Column(
                    children: [
              Container(
                height: Get.height * 0.31,
                child: Column(
                  children: [
                    BattleName.getName('SomeLongReallyve'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarInTheBattle.getAvatar('Test'),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInBattle.getChar(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill()))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInBattle.getChar(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill()))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CharInBattle.getChar(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            Random().nextInt(3),
                                            (index) =>
                                                SkillWhileAtached.getSkill()))
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
                            BattleName.getName('SomeName'),
                            AvatarInTheBattle.getAvatar('Test'),
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
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) =>
                                                    SkillWhileAtached.getSkill())),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill('Skill 4'),
                                            BattleMySkill.getMySkill('Skill 3'),
                                            BattleMySkill.getMySkill('Skill 2'),
                                            BattleMySkill.getMySkill('Skill 1'),
                                            ChoosenSkill.getChoosenSkill('skill')
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInBattle.getChar(),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) =>
                                                    SkillWhileAtached.getSkill())),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill('Skill 4'),
                                            BattleMySkill.getMySkill('Skill 3'),
                                            BattleMySkill.getMySkill('Skill 2'),
                                            BattleMySkill.getMySkill('Skill 1'),
                                            ChoosenSkill.getChoosenSkill('skill')
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInBattle.getChar(),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                Random().nextInt(3),
                                                (index) =>
                                                    SkillWhileAtached.getSkill())),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            BattleMySkill.getMySkill('Skill 4'),
                                            BattleMySkill.getMySkill('Skill 3'),
                                            BattleMySkill.getMySkill('Skill 2'),
                                            BattleMySkill.getMySkill('Skill 1'),
                                            ChoosenSkill.getChoosenSkill('skill')
                                          ],
                                        )
                                      ],
                                    ),
                                    CharInBattle.getChar(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    BattleInfoPanel.getPanel(),
                    EnergyBattle.getEnergy(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoveButton(),
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

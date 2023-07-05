import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';

import '../../controllers/routing/app_pages.dart';
import '../../elements/info_board.dart';
import '../../elements/line_beetwen.dart';
import '../../widgets/menubutton.dart';

class PlayMenu extends StatelessWidget {
  const PlayMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainGameController>(builder: (controller) {
        return SafeArea(
            child: Column(
          children: [
            InfoBoard(),
            Line.getLine(),
            MenuButton(
                title: 'Start Ladder Battle',
                onTap: () {
                  if (controller.checkAndSayIfNotFullSet()) {
                    controller.gameType = GameType.LadderBattle;
                    Get.toNamed(Routes.WAITING_PAGE);
                  }
                }),
            MenuButton(
                title: 'Start Quik Battle',
                onTap: () {
                  if (controller.checkAndSayIfNotFullSet()) {
                    controller.gameType = GameType.QuickBattle;
                    Get.toNamed(Routes.WAITING_PAGE);
                  }
                }),
            MenuButton(
                title: 'Start Private Battle',
                onTap: () {
                  if (controller.checkAndSayIfNotFullSet()) {
                    controller.gameType = GameType.PrivateBattle;
                    controller.privateBattleDialog(context);
                  }
                }),
          ],
        ));
      }),
    );
  }
}

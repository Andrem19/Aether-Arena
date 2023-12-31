import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';
import 'package:the_test_naruto_arena/elements/info_board.dart';
import 'package:the_test_naruto_arena/elements/line_beetwen.dart';
import 'package:the_test_naruto_arena/widgets/menubutton.dart';

import 'play_switcher.dart';

class MenuElement extends StatelessWidget {
  const MenuElement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainGameController>(builder: (controller) {
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InfoBoard(),
              Line.getLine(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.userProfile.value.wantToPlay
                      ? 'I agree to receive invitations to the game'
                      : 'I do not agree to receive invitations to the game'),
                  PlaySwitcher.getPlaySwitcher(controller),
                ],
              ),
              MenuButton(
                title: 'Play',
                onTap: () => Get.toNamed(Routes.PLAY_MENU),
              ),
              MenuButton(
                title: 'Cards',
                onTap: () => Get.toNamed(Routes.CARDS_COLLECTION),
              ),
              MenuButton(
                title: 'Settings',
                onTap: () => Get.toNamed(Routes.SETTINGS),
              ),
              MenuButton(
                title: 'Battle Test',
                onTap: () => Get.toNamed(Routes.BATTLE_ACT),
              ),
            ],
          ),
        ),
      );
    });
  }
}

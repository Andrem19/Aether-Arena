import 'package:flutter/material.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';

class PlaySwitcher {
  static Widget getPlaySwitcher(MainGameController controller) {
    return Center(
      child: Switch(
        value: controller.userProfile.value.wantToPlay,
        onChanged: (value) {
          controller.userProfile.value.wantToPlay = value;
          controller.changeWantToPlay();
          controller.update();
        },
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
    );
  }
}

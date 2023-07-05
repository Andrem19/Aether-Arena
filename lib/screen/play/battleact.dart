import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';

class BattleAct extends StatelessWidget {
  const BattleAct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        return Scaffold(
          body: Center(child: Container(
            child: Text(controller.currentGameId),
          )),
        );
      }
    );
  }
}

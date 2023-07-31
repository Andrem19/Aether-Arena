import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

import '../models/skill.dart';

class ChoosenSkill {
  static Widget getChoosenSkill(int position, double width) {
    return GetBuilder<BattleController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
        child: Container(
          width: width * 0.1,
          height: width * 0.1,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Stack(children: [
            Image.asset('assets/default_avatar.jpg'),
            Text('')
          ]),
        ),
      );
    });
  }
}

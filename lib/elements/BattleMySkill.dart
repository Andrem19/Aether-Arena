import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BattleMySkill {
  static Widget getMySkill(String skill) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      child: Container(
        width: Get.width * 0.1,
        height: Get.width * 0.1,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Stack(children: [
          Image.asset('assets/default_skill.jpg'),
          Text(skill)
          ]),
      ),
    );
  }
}

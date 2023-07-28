import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/skill.dart';

class BattleMySkill {
  static Widget getMySkill(Skill skill, double width) {
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
          skill.img == ''? Image.asset('assets/default_skill.jpg') : Image.asset(skill.img),
          Text(skill.name)
          ]),
      ),
    );
  }
}

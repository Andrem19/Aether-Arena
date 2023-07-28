
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkillWhileAtached {
  static Widget getSkill(double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 0, 3),
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: width * 0.05,
          height: width * 0.05,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Image.asset('assets/default_skill.jpg'),),
      ),
    );
  }
}
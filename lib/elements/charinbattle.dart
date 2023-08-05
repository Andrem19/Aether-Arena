import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

import '../models/char_in_battle.dart';
import '../models/enums.dart';

class CharInTheBattle {
  static Widget getChar(bool isEnemy, CharInBattle char, double width) {
    return GetBuilder<BattleController>(builder: (controller) {
      bool isTarget = false;
      if (isEnemy &&
          char.stats.health > 0 &&
          controller.chooseTargetEnemy.value) {
        isTarget = true;
      }
      if (!isEnemy &&
          char.stats.health > 0 &&
          controller.chooseTargetAlly.value) {
        isTarget = true;
      }
      if (char.stats.health > 0 && controller.chooseTargetAll.value) {
        isTarget = true;
      }
      if (!isEnemy &&
          char.stats.health > 0 &&
          char.id == controller.focus.myCharId &&
          controller.chooseTargetMe.value) {
        isTarget = true;
      }
      bool clicable = false;
      if (controller.focus.target == Target.AllAliveInGame &&
          char.stats.health > 0) {
        clicable = true;
      } else if (isEnemy &&
          controller.focus.target == Target.AllAliveAnemy &&
          char.stats.health > 0) {
        clicable = true;
      } else if (!isEnemy &&
          controller.focus.target == Target.AllAliveAlly &&
          char.stats.health > 0) {
        clicable = true;
      } else if (!isEnemy &&
          controller.focus.target == Target.Myself &&
          char.stats.health > 0 &&
          char.id == controller.focus.myCharId) {
        clicable = true;
      }
      return InkWell(
        onTap: clicable
            ? () {
                controller.setTarget(char.id);
                controller.passFocusToTheMove();
                controller.stopTimerBlinking();
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: isTarget ? 0.4 : 1,
                duration: Duration(milliseconds: 800),
                child: Container(
                  width: width * 0.18,
                  height: width * 0.18,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(char.img),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Container(
                      width: width * 0.18,
                      height: width * 0.03,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightGreen.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: char.stats.health / 30 * width * 0.18,
                      height: width * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightGreen.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "${char.stats.health}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

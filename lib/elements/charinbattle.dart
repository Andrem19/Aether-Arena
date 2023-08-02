import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

import '../models/char_in_battle.dart';

class CharInTheBattle {
  static Widget getChar(bool isEnemy, CharInBattle char, double width) {
    return GetBuilder<BattleController>(builder: (controller) {
      bool isTarget = false;
      if (isEnemy && char.health > 0 && controller.chooseTarget.value) {
        isTarget = true;
      }
      return InkWell(
        onTap: controller.chooseTarget.value
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
              Opacity(
                opacity: isTarget ? 0.5 : 1,
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
                      width: char.health / 100 * width * 0.18,
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
                        "${char.health}%",
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

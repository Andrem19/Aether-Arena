import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/models/enums.dart';

class EnergyBattle {
  static Widget getEnergy() {
    final double size = 12;
    return GetBuilder<BattleController>(
      builder: (controller) {
        return Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
              child: Row(
                children: [
                  Container(
                    width: size,
                    height: size,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(controller.myEnergy.value[Energy.PHYSICAL].toString()),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
              child: Row(
                children: [
                  Container(
                    width: size,
                    height: size,
                    color: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(controller.myEnergy.value[Energy.ARCANE].toString()),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
              child: Row(
                children: [
                  Container(
                    width: size,
                    height: size,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(controller.myEnergy.value[Energy.UNIQUE].toString()),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
              child: Row(
                children: [
                  Container(
                    width: size,
                    height: size,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(controller.myEnergy.value[Energy.WILLPOWER].toString()),
                  )
                ],
              ),
            ),
            Spacer(),
          ],
        );
      }
    );
  }
}

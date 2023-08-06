import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

import '../models/enums.dart';

class BattleInfoPanel {
  static Widget getPanel(double width) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        bool isLongText = controller.infoText.value.length > 110;
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.white,
            height: Get.height * 0.09,
            width: width * 0.95,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.infoText.value,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isLongText ? 12.0 : null,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 3,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                        getEnergySquares(controller.needCurrentSkill.value),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  static List<Widget> getEnergySquares(Map<Energy, int> needEnergy) {
    List<Widget> listSquares = [];
    if (needEnergy.containsKey(Energy.ARCANE)) {
      listSquares.add(
        EnergySquare(needEnergy, Energy.ARCANE),
      );
      listSquares.add(SizedBox(
        width: 4,
      ));
    }
    if (needEnergy.containsKey(Energy.WILLPOWER)) {
      listSquares.add(
        EnergySquare(needEnergy, Energy.WILLPOWER),
      );
      listSquares.add(SizedBox(
        width: 4,
      ));
    }
    if (needEnergy.containsKey(Energy.PHYSICAL)) {
      listSquares.add(
        EnergySquare(needEnergy, Energy.PHYSICAL),
      );
      listSquares.add(SizedBox(
        width: 4,
      ));
    }
    if (needEnergy.containsKey(Energy.UNIQUE)) {
      listSquares.add(
        EnergySquare(needEnergy, Energy.UNIQUE),
      );
      listSquares.add(SizedBox(
        width: 4,
      ));
    }
    if (needEnergy.containsKey(Energy.RANDOM)) {
      listSquares.add(
        EnergySquare(needEnergy, Energy.RANDOM),
      );
      listSquares.add(SizedBox(
        width: 4,
      ));
    }
    return listSquares;
  }

  static Color getColor(Map<Energy, int> myEnergy, Energy energyType) {
    if (myEnergy.containsKey(energyType)) {
      int energyCount = myEnergy[energyType] ?? 0;
      switch (energyType) {
        case Energy.ARCANE:
          return Colors.blue;
        case Energy.PHYSICAL:
          return Colors.green;
        case Energy.UNIQUE:
          return Colors.red;
        case Energy.WILLPOWER:
          return Colors.white;
        case Energy.RANDOM:
          return Colors.black;
        default:
          return Colors.transparent;
      }
    } else {
      return Colors.transparent;
    }
  }
}

class EnergySquare extends StatelessWidget {
  final Map<Energy, int> needEnergy;
  final Energy energyType;

  EnergySquare(this.needEnergy, this.energyType);

  @override
  Widget build(BuildContext context) {
    int energyCount = needEnergy[energyType] ?? 0;
    Color energyColor = BattleInfoPanel.getColor(needEnergy, energyType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: energyColor,
            border: Border.all(color: Colors.black),
          ),
        ),
        SizedBox(height: 2),
        Text(
          energyCount.toString(),
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ],
    );
  }
}

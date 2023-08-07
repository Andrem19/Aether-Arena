import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/models/enum_serializer.dart';
import 'package:the_test_naruto_arena/services/battle_func.dart';

import '../models/enums.dart';

class MoveModalWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(builder: (controller) {
      int totalRandom = controller.my_move.value.totalRandomEnergy;
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('CHOOSE ${totalRandom} RANDOM ENERGY'),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  controller.my_move.value.char_1.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(
                          controller.my_char_1.value
                              .getSkilByID(
                                  controller.my_move.value.char_1.skillId)
                              .img,
                          height: 50,
                        ),
                  controller.my_move.value.char_2.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(
                          controller.my_char_2.value
                              .getSkilByID(
                                  controller.my_move.value.char_2.skillId)
                              .img,
                          height: 50,
                        ),
                  controller.my_move.value.char_3.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(
                          controller.my_char_3.value
                              .getSkilByID(
                                  controller.my_move.value.char_3.skillId)
                              .img,
                          height: 50,
                        ),
                ],
              ),
              SizedBox(height: 20),
              energyControl(controller, Colors.green, Energy.PHYSICAL),
              energyControl(controller, Colors.blue, Energy.ARCANE),
              energyControl(controller, Colors.red, Energy.UNIQUE),
              energyControl(controller, Colors.white, Energy.WILLPOWER),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('CONFIRM'),
                    onPressed: controller.my_move.value.totalRandomEnergy ==
                            BattleFunc.getEnergySum(
                                controller.randomIGive.value)
                        ? () {
                            controller.applyMyMove();
                            controller.execMyMove();
                            controller.endMoveAndPass();
                            Navigator.of(context).pop();
                            controller.resetEnergyIGive();
                          }
                        : null,
                  ),
                  ElevatedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      controller.transferEnergyBack();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget energyControl(
      BattleController controller, Color color, Energy energy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${EnumSerializer.energyToString(energy)} ${controller.myEnergy.value[energy]}',
          style: TextStyle(fontSize: 10),
        ),
        Container(
          color: color,
          width: 12,
          height: 12,
        ),
        IconButton(
          icon: Icon(
            Icons.remove,
            size: 10,
          ),
          onPressed: () {
            controller.returnRandomEnergy(energy);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            size: 10,
          ),
          onPressed: () {
            controller.subtractRandomEnergy(energy);
          },
        ),
        Container(
          color: color,
          width: 12,
          height: 12,
        ),
        Text(
          '${controller.randomIGive.value[energy]} ${EnumSerializer.energyToString(energy)}',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}

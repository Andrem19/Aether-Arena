import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/models/enum_serializer.dart';

import '../models/enums.dart';

class MoveModalWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(builder: (controller) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('CHOOSE ${0} RANDOM ENERGY'),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  controller.my_move.char_1.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(controller.my_char_1.value
                          .getSkilByID(controller.my_move.char_1.skillId)
                          .img, height: 50,),
                  controller.my_move.char_2.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(controller.my_char_2.value
                          .getSkilByID(controller.my_move.char_2.skillId)
                          .img, height: 50,),
                  controller.my_move.char_3.empty
                      ? Icon(Icons.square, size: 50)
                      : Image.asset(controller.my_char_3.value
                          .getSkilByID(controller.my_move.char_3.skillId)
                          .img, height: 50,),
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
                    onPressed: () {
                      
                    },
                  ),
                  ElevatedButton(
                    child: Text('CANCEL'),
                    onPressed: () {
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
        Text('${EnumSerializer.energyToString(energy)} ${0}', style: TextStyle(fontSize: 10),),
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
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.add,
            size: 10,
          ),
          onPressed: () {},
        ),
        Container(
          color: color,
          width: 12,
          height: 12,
        ),
        Text('${0} ${EnumSerializer.energyToString(energy)}', style: TextStyle(fontSize: 10),),
      ],
    );
  }
}


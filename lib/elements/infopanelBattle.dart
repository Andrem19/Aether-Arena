import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

class BattleInfoPanel {
  static Widget getPanel(double width) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          child: Container(
            color: Colors.white,
            height: Get.height * 0.09,
            width: width * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(controller.infoText.value, 
              style: TextStyle(
                color: Colors.black),
                textAlign: TextAlign.center,
                maxLines: 7,),
            ),
          ),
        );
      }
    );
  }
}

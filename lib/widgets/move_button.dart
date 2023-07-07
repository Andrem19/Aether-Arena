import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

class MoveButton extends StatelessWidget {
  const MoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        return InkWell(
          onTap: () {},
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Get.width / 2,
                height: Get.height / 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  height: Get.height / 20,
                  width: Get.width /
                      2 *
                      ((20.01 - controller.timerValue.value) / 20),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                'Click when ready',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

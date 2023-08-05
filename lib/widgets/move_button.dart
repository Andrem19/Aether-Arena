import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/elements/moveModalWindow.dart';

class MoveButton extends StatelessWidget {
  double width;
  MoveButton({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        return InkWell(
          onTap: controller.whoIsMove.value == controller.myRole? () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MoveModalWindow();
              },
            );
          } : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: width / 2,
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
                  width: width /
                      2 *
                      ((21.01 - controller.timerValue.value) / 20),
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

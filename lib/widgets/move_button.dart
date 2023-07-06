import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';

class MoveButton extends StatelessWidget {
  const MoveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleController>(
      builder: (controller) {
        double progress = controller.timerValue.value / 20.0;
        Color? buttonColor = Color.lerp(Colors.green, Colors.grey, progress);

        return Container(
          color: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * progress,
            height: Get.height * 0.07,
            color: buttonColor,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Click when ready',
                style: TextStyle(color: Colors.black),
              ),
            )
          ),
        );
      },
    );
  }
}
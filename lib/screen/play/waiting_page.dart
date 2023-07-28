import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/elements/shell.dart';

import '../../controllers/waiting_controller.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shell(
      content: GetBuilder<WaitingController>(builder: (controller) {
        return Center(
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(controller.gameStatus.value),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(controller.randomAdvice.value, maxLines: 10, textAlign: TextAlign.center,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

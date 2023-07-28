import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/elements/shell.dart';

import '../../elements/info_board.dart';
import '../../elements/line_beetwen.dart';

class CardCollection extends StatelessWidget {
  const CardCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Shell(
      content: GetBuilder<MainGameController>(builder: (controller) {
        return SafeArea(
          child: Column(
            children: [
              InfoBoard(),
              Line.getLine(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 133, 131, 131),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black26,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children:
                        List.generate(controller.characters.length, (index) {
                      return InkWell(
                        onTap: () {
                          controller.showCardDialog(context, controller.characters[index]);
                        },
                        child: Opacity(
                          opacity: controller.characters[index].isOpen
                              ? 1
                              : 0.4,
                          child: controller.characters[index].isOpen ? LongPressDraggable(
                            data: controller.characters[index],
                            feedback: Card(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                        controller.characters[index].img, height: Get.height /7,),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Name'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            child: Card(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                        controller.characters[index].img),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Name'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ) : Card(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                        controller.characters[index].img),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Name'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                        ),
                      );
                    }),
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

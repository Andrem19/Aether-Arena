import 'package:flutter/material.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';

class ExpLine {

  static Widget getExpLine(MainGameController controller) {
    var levelInfo = controller.getLevel();
    int oneProc = levelInfo['kof']! ~/ 100;
    int myExp = levelInfo['myExp']!;
    double perc = myExp / oneProc;
    return Stack(
      children: [
        Container(
          width: perc,
          height: 18,
          color: Colors.green,
        ),
        Container(
          width: 100,
          height: 19,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            color: Colors.transparent,
          ),
          child: Center(child: Text(levelInfo['level'].toString())),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/char_in_battle.dart';

class CharInTheBattle {
  static Widget getChar(CharInBattle char, double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
      child: Container(
        width: width * 0.18,
        height: width * 0.18,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Image.asset(char.img),),
    );
  }
}

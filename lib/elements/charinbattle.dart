import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharInBattle {
  static Widget getChar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
      child: Container(
        width: Get.width * 0.18,
        height: Get.width * 0.18,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Image.asset('assets/images/Priest.jpg'),),
    );
  }
}

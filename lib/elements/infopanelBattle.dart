import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BattleInfoPanel {
  static Widget getPanel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,5,0,5),
      child: Container(
        color: Colors.white,
        height: Get.height * 0.11,
        width: Get.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, Some text, ', 
          style: TextStyle(
            color: Colors.black),
            textAlign: TextAlign.center,
            maxLines: 7,),
        ),
      ),
    );
  }
}

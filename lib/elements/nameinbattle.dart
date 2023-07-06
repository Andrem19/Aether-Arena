import 'package:flutter/material.dart';

class BattleName {
  static Widget getName(String name) {
    double maxTextWidth = 8;
    double fontSize = 20;
    if (name.length > maxTextWidth) {
      fontSize = 12;
    }
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            name,
            style: TextStyle(
              fontSize: fontSize,
              shadows: [
                Shadow(
                  color: Colors.black,
                  offset: Offset(0, 0),
                  blurRadius: 15.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

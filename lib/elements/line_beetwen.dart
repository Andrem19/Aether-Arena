import 'package:flutter/material.dart';

class Line {
  static Widget getLine() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,5,0,15),
      child: Container(
        color: Colors.white,
        height: 2,
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnergyBattle {
  static Widget getEnergy() {
    final double size = 12;
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text('0'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                color: Colors.blueAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text('0'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text('0'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
          child: Row(
            children: [
              Container(
                width: size,
                height: size,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text('0'),
              )
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}

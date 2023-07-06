import 'package:flutter/material.dart';

class EnergyBattle {
  static Widget getEnergy() {
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 0, 3),
          child: Row(
            children: [
              Container(
                width: 13,
                height: 13,
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
                width: 13,
                height: 13,
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
                width: 13,
                height: 13,
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
                width: 13,
                height: 13,
                color: Colors.black,
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
                width: 13,
                height: 13,
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

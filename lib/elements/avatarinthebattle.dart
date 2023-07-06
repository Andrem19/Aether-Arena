import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvatarInTheBattle {
  static Widget getAvatar(String gameInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
      child: Container(
        width: Get.width * 0.27,
        height: Get.width * 0.27,
        child: Stack(
          children: [
            Image.asset('assets/default_avatar.jpg'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rank',
                  style: TextStyle(
                    fontSize: 18,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  'Level: 1',
                  style: TextStyle(
                    fontSize: 18,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

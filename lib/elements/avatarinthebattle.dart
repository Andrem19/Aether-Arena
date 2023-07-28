import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/models/account_player_data.dart';

class AvatarInTheBattle {
  static Widget getAvatar(AccountPlayerData gameInfo, double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 3),
      child: Container(
        width: width * 0.27,
        height: width * 0.27,
        child: Stack(
          children: [
            gameInfo.avatar == ""? Image.asset('assets/default_avatar.jpg') : Image.network(gameInfo.avatar),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameInfo.rank,
                  style: TextStyle(
                    fontSize: 18,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  'Level: ${gameInfo.level}',
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

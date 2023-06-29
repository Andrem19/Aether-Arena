
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';
import 'package:the_test_naruto_arena/widgets/menubutton.dart';

class MenuElement extends StatelessWidget {
  const MenuElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MenuButton(title: 'Play', onTap: () => Get.toNamed(Routes.PLAY_MENU),),
          MenuButton(title: 'Cards', onTap: () => Get.toNamed(Routes.CARDS_COLLECTION),),
          MenuButton(title: 'Settings', onTap: () => Get.toNamed(Routes.SETTINGS),)
        ],
      ),
    );
  }
}
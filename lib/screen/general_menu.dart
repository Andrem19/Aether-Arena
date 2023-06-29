import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/main_game_controller.dart';
import 'package:the_test_naruto_arena/elements/menu.dart';

class GeneralMenu extends StatefulWidget {
  const GeneralMenu({super.key});

  @override
  State<GeneralMenu> createState() => _GeneralMenuState();
}

class _GeneralMenuState extends State<GeneralMenu> {
  // @override
  // void didChangeDependencies() {
  //   final authProvider = Get.find<AuthProviderController>();
  //   authProvider.updateEmailVerification();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthProviderController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text(controller.userProfile.value.userName),
              actions: [
                IconButton(
                    onPressed: () {
                      controller.logOut();
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: MenuElement());
      },
    );
  }
}

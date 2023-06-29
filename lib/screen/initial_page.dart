import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';

import 'auth_screen.dart';
import 'general_menu.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AuthProviderController>(builder: (controller) {
      return Container(
        child: controller.userAuth.value
            ? const GeneralMenu()
            : const AuthScreen(),
      );
    }));
  }
}

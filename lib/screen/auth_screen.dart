import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/routing/app_pages.dart';
import 'package:the_test_naruto_arena/screen/email_pass_screen.dart';

import '../widgets/authbutton.dart';
import 'google_sign_in_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose an authentication method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            AuthButton(
              iconData: Icons.email,
              title: 'Email/Password',
              onTap: () {
                Get.toNamed(Routes.EMAIL_AUTH);
              },
            ),
            AuthButton(
              iconData: FontAwesomeIcons.google,
              title: 'Google',
              onTap: () {
                Get.toNamed(Routes.GOOGLE_AUTH);
              },
            )
          ],
        ),
      ),
    ));
  }
}
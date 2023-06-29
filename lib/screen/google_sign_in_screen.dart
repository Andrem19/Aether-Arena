import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/screen/general_menu.dart';

import '../widgets/authbutton.dart';

class GoogleSignIn extends StatelessWidget {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const GeneralMenu();
          }
          return Scaffold(
            body: GetBuilder<AuthProviderController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: AuthButton(
                    iconData: FontAwesomeIcons.google,
                    title: 'Google',
                    onTap: () {
                      controller.signInWithGoogle();
                    },
                  ),
                ),
              );
            }),
          );
        });
  }
}
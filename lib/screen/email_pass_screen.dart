import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/screen/general_menu.dart';

import '../elements/shell.dart';
import '../widgets/custom_text_field.dart';

class EmailPassScreen extends StatelessWidget {
  const EmailPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthProviderController>(builder: (controller) {
      return Shell(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Save email and password: '),
                    Switch(
                      value: controller.saveInPref.value,
                      onChanged: (value) {
                        controller.saveInPref.value = value;
                        controller.update();
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                CustomTextField(
                    controller: controller.emailController,
                    iconData: Icons.email,
                    hintText: 'Email'),
                if (controller.authType == AuthType.signUp)
                  CustomTextField(
                      controller: controller.userNameController,
                      iconData: Icons.person,
                      hintText: 'User Name'),
                CustomTextField(
                    controller: controller.passwordController,
                    iconData: Icons.password,
                    hintText: 'Password'),
                TextButton(
                    onPressed: () {
                      controller.authenticate();
                    },
                    child: controller.authType == AuthType.signUp
                        ? const Text('Sign Up')
                        : const Text('Sign In')),
                TextButton(
                    onPressed: () {
                      controller.setAuthType();
                    },
                    child: controller.authType == AuthType.signUp
                        ? const Text('Already have an account')
                        : const Text('Create an account')),
                if (controller.authType == AuthType.signIn)
                  TextButton(
                      onPressed: () {
                        controller.resetPassword(context);
                      },
                      child: const Text('Reset Password'))
              ],
            ),
          ),
        ),
      );
    });
  }
}

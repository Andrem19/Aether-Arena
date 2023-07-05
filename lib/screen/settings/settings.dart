import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/settings_controller.dart';
import 'package:the_test_naruto_arena/elements/appbar.dart';

import '../../widgets/custom_text_field.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPages.getAppBar('Settings'),
      body: GetBuilder<SettingsController>(
        builder: (controller) {
          return Container(
            child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'User Name:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.size.width / 2,
                            child: CustomTextField(
                                controller: controller.userNameController,
                                iconData: Icons.person,
                                hintText: 'User Name'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                await controller.updateName();
                              },
                              child: Text('Submit')),
                      
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Add To Black List:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.size.width / 2,
                            child: CustomTextField(
                                controller: controller.blackListName,
                                iconData: Icons.person,
                                hintText: 'User Name'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                controller.addToBlackList();
                              },
                              child: Text('Submit')),
                      
                        ],
                      ),
                    ],
                  ),
          );
        }
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarPages {
  static AppBar getAppBar(String name) {
    return AppBar(
      title: Center(child: Text(name)),
      actions: [
        SizedBox(
          width: 25,
        )
      ],
      centerTitle: true,
      leading: IconButton(
        onPressed: () async {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
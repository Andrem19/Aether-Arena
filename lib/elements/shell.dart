import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shell extends StatelessWidget {
  final Widget content;

  const Shell({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: isWeb
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 72, 68, 68),
                  boxShadow: const [
                    BoxShadow(color: Colors.green, spreadRadius: 3),
                  ],
                )
              : null,
          width: isWeb ? Get.width / 3 : Get.width,
          child: content,
        ),
      ),
    );
  }
}
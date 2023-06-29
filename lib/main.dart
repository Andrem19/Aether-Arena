import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controllers/binding/bindings.dart';
import 'controllers/routing/app_pages.dart';
import 'firebase_options.dart';
import 'keys.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
  //     .then((_) {
  //   runApp(const MyApp());
  // });
  runApp(const MyApp());
}

Future<void> initHive() async {
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter('newhive');
  await Hive.openBox('credentials');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: Keys.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Naruto Arena',
      theme: ThemeData(
        // fontFamily: 'MazeRush',
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.grey,
        ),
      ),
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      initialBinding: MainBinding(),
    );
  }
}

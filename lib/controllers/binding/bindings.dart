import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';
import 'package:the_test_naruto_arena/controllers/battle_controller.dart';
import 'package:the_test_naruto_arena/controllers/settings_controller.dart';
import 'package:the_test_naruto_arena/controllers/waiting_controller.dart';

import '../ad_and_visual_controller.dart';
import '../main_game_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthProviderController(), permanent: true);
    Get.put(MainGameController(), permanent: true);
    Get.put(AdAndVisualController(), permanent: true);

    Get.find<AuthProviderController>().initialize(Get.find<MainGameController>());
    Get.find<MainGameController>().initialize(Get.find<AuthProviderController>());
  }
}
class SettingsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController(), permanent: false);
  }
}
class WaitingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WaitingController(), permanent: false);
  }
}

class BattleControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BattleController(), permanent: false);
  }
}
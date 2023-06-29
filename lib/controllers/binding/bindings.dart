import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/auth_provider.dart';

import '../ad_and_visual_controller.dart';
import '../main_game_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthProviderController(), permanent: true);
    Get.put(MainGameController(), permanent: true);
    Get.put(AdAndVisualController(), permanent: true);
  }
}
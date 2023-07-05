import 'package:get/get.dart';
import 'package:the_test_naruto_arena/controllers/binding/bindings.dart';
import 'package:the_test_naruto_arena/screen/auth_screen.dart';
import 'package:the_test_naruto_arena/screen/card_collection/cards.dart';
import 'package:the_test_naruto_arena/screen/email_pass_screen.dart';
import 'package:the_test_naruto_arena/screen/google_sign_in_screen.dart';
import 'package:the_test_naruto_arena/screen/initial_page.dart';
import 'package:the_test_naruto_arena/screen/play/playmenu.dart';
import 'package:the_test_naruto_arena/screen/settings/settings.dart';

import '../../screen/general_menu.dart';
import '../../screen/play/battleact.dart';
import '../../screen/play/waiting_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Paths.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.GENERAL_MENU,
      page: () => GeneralMenu(),
    ),
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialPage(),
    ),
    GetPage(
      name: _Paths.AUTHORIZATION,
      page: () => AuthScreen(),
    ),
    GetPage(
      name: _Paths.EMAIL_AUTH,
      page: () => EmailPassScreen(),
    ),
    GetPage(
      name: _Paths.GOOGLE_AUTH,
      page: () => GoogleSignIn(),
    ),
    GetPage(
      name: _Paths.CARDS_COLLECTION,
      page: () => CardCollection(),
    ),
    GetPage(
      name: _Paths.PLAY_MENU,
      page: () => PlayMenu(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsControllerBinding()
    ),
    GetPage(
      name: _Paths.WAITING_PAGE,
      page: () => WaitingPage(),
      binding: WaitingControllerBinding()
    ),
    GetPage(
      name: _Paths.BATTLE_ACT,
      page: () => BattleAct(),
      binding: BattleControllerBinding()
    ),
  ];
}

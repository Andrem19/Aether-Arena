part of 'app_pages.dart';

abstract class Routes {
  Routes_();

  static const INITIAL = _Paths.INITIAL;
  static const AUTHORIZATION = _Paths.AUTHORIZATION;
  static const GENERAL_MENU = _Paths.GENERAL_MENU;
  static const EMAIL_AUTH = _Paths.EMAIL_AUTH;
  static const GOOGLE_AUTH = _Paths.GOOGLE_AUTH;
  static const PLAY_MENU = _Paths.PLAY_MENU;
  static const SETTINGS = _Paths.SETTINGS;
  static const CARDS_COLLECTION = _Paths.CARDS_COLLECTION;

}

abstract class _Paths {
  static const INITIAL = "/init";
  static const AUTHORIZATION = "/auth";
  static const GENERAL_MENU = "/home";
  static const EMAIL_AUTH = "/email_auth";
  static const GOOGLE_AUTH = "/google_auth";
  static const PLAY_MENU = "/play_menu";
  static const SETTINGS = "/settings";
  static const CARDS_COLLECTION = "/cards_collection";

}
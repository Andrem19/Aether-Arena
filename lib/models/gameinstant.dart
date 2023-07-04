// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_test_naruto_arena/models/char_in_battle.dart';

import 'enums.dart';

class GameInstant {
  String PlayerA_uid;
  String PlayerB_uid;
  List<CharInBattle> PlayerA_charSet;
  List<CharInBattle> PlayerB_charSet;
  Map<Energy, int> PlayerA_energy;
  Map<Energy, int> PlayerB_energy;


  GameInstant({
    required this.PlayerA_uid,
    required this.PlayerB_uid,
    required this.PlayerA_charSet,
    required this.PlayerB_charSet,
    required this.PlayerA_energy,
    required this.PlayerB_energy,
  });
}
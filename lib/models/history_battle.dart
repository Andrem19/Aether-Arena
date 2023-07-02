import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HistoryBattle {
  String identificator;
  String enemyName;
  List<int> hisSet;
  List<int> mySet;
  bool isIWinner;
  HistoryBattle({
    required this.identificator,
    required this.enemyName,
    required this.hisSet,
    required this.mySet,
    required this.isIWinner,
  });
  static HistoryBattle getEmptyHistoryBattle() {
    return HistoryBattle(
      identificator: "",
      enemyName: "",
      hisSet: [],
      mySet: [],
      isIWinner: false,
    );
  }

  HistoryBattle copyWith({
    String? identificator,
    String? enemyName,
    List<int>? hisSet,
    List<int>? mySet,
    bool? isIWinner,
  }) {
    return HistoryBattle(
      identificator: identificator ?? this.identificator,
      enemyName: enemyName ?? this.enemyName,
      hisSet: hisSet ?? this.hisSet,
      mySet: mySet ?? this.mySet,
      isIWinner: isIWinner ?? this.isIWinner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identificator': identificator,
      'enemyName': enemyName,
      'hisSet': hisSet,
      'mySet': mySet,
      'isIWinner': isIWinner,
    };
  }

  factory HistoryBattle.fromMap(Map<String, dynamic> map) {
    return HistoryBattle(
      identificator: map['identificator'] as String,
      enemyName: map['enemyName'] as String,
      hisSet: List<int>.from((map['hisSet'] as List<int>)),
      mySet: List<int>.from((map['mySet'] as List<int>)),
      isIWinner: map['isIWinner'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryBattle.fromJson(String source) =>
      HistoryBattle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoryBattle(identificator: $identificator, enemyName: $enemyName, hisSet: $hisSet, mySet: $mySet, isIWinner: $isIWinner)';
  }

  @override
  bool operator ==(covariant HistoryBattle other) {
    if (identical(this, other)) return true;
  
    return 
      other.identificator == identificator &&
      other.enemyName == enemyName &&
      listEquals(other.hisSet, hisSet) &&
      listEquals(other.mySet, mySet) &&
      other.isIWinner == isIWinner;
  }

  @override
  int get hashCode {
    return identificator.hashCode ^
      enemyName.hashCode ^
      hisSet.hashCode ^
      mySet.hashCode ^
      isIWinner.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:the_test_naruto_arena/models/personal_settings.dart';

class UserProfile {
  bool isLoaded;
  String uid;
  String email;
  String userName;
  PersonalSettings personalSettings;
  List<int> mySet;
  String avatar;
  int nickWasChanged;
  int expirience;
  bool isUserInGame;
  bool wantToPlay;
  UserProfile({
    required this.isLoaded,
    required this.uid,
    required this.email,
    required this.userName,
    required this.personalSettings,
    required this.mySet,
    required this.avatar,
    required this.nickWasChanged,
    required this.expirience,
    required this.isUserInGame,
    required this.wantToPlay,
  });
  static UserProfile getEmpty() {
    return UserProfile(
        isLoaded: false,
        uid: '',
        email: '',
        userName: '',
        personalSettings: PersonalSettings.getDefault(),
        mySet: [0, 0, 0],
        avatar: '',
        nickWasChanged: 0,
        expirience: 0,
        isUserInGame: true,
        wantToPlay: true);
  }

  UserProfile copyWith({
    bool? isLoaded,
    String? uid,
    String? email,
    String? userName,
    PersonalSettings? personalSettings,
    List<int>? mySet,
    String? avatar,
    int? nickWasChanged,
    int? expirience,
    bool? isUserInGame,
    bool? wantToPlay,
  }) {
    return UserProfile(
      isLoaded: isLoaded ?? this.isLoaded,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      personalSettings: personalSettings ?? this.personalSettings,
      mySet: mySet ?? this.mySet,
      avatar: avatar ?? this.avatar,
      nickWasChanged: nickWasChanged ?? this.nickWasChanged,
      expirience: expirience ?? this.expirience,
      isUserInGame: isUserInGame ?? this.isUserInGame,
      wantToPlay: wantToPlay ?? this.wantToPlay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoaded': isLoaded,
      'uid': uid,
      'email': email,
      'userName': userName,
      'personalSettings': personalSettings.toMap(),
      'mySet': mySet,
      'avatar': avatar,
      'nickWasChanged': nickWasChanged,
      'expirience': expirience,
      'isUserInGame': isUserInGame,
      'wantToPlay': wantToPlay,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      isLoaded: map['isLoaded'] as bool,
      uid: map['uid'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      personalSettings: PersonalSettings.fromMap(map['personalSettings'] as Map<String,dynamic>),
      mySet: List<int>.from((map['mySet'] as List<int>)),
      avatar: map['avatar'] as String,
      nickWasChanged: map['nickWasChanged'] as int,
      expirience: map['expirience'] as int,
      isUserInGame: map['isUserInGame'] as bool,
      wantToPlay: map['wantToPlay'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(isLoaded: $isLoaded, uid: $uid, email: $email, userName: $userName, personalSettings: $personalSettings, mySet: $mySet, avatar: $avatar, nickWasChanged: $nickWasChanged, expirience: $expirience, isUserInGame: $isUserInGame, wantToPlay: $wantToPlay)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;
  
    return 
      other.isLoaded == isLoaded &&
      other.uid == uid &&
      other.email == email &&
      other.userName == userName &&
      other.personalSettings == personalSettings &&
      listEquals(other.mySet, mySet) &&
      other.avatar == avatar &&
      other.nickWasChanged == nickWasChanged &&
      other.expirience == expirience &&
      other.isUserInGame == isUserInGame &&
      other.wantToPlay == wantToPlay;
  }

  @override
  int get hashCode {
    return isLoaded.hashCode ^
      uid.hashCode ^
      email.hashCode ^
      userName.hashCode ^
      personalSettings.hashCode ^
      mySet.hashCode ^
      avatar.hashCode ^
      nickWasChanged.hashCode ^
      expirience.hashCode ^
      isUserInGame.hashCode ^
      wantToPlay.hashCode;
  }
}

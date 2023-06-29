// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfile {
  bool isLoaded;
  String uid;
  String email;
  String userName;
  UserProfile({
    required this.isLoaded,
    required this.uid,
    required this.email,
    required this.userName,
  });
  static UserProfile getEmpty() {
    return UserProfile(
        isLoaded: false, uid: '', email: '', userName: '');
  }

  UserProfile copyWith({
    bool? isLoaded,
    String? uid,
    String? email,
    String? userName,
  }) {
    return UserProfile(
      isLoaded: isLoaded ?? this.isLoaded,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoaded': isLoaded,
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      isLoaded: map['isLoaded'] as bool,
      uid: map['uid'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(isLoaded: $isLoaded, uid: $uid, email: $email, userName: $userName)';
  }

  @override
  bool operator ==(covariant UserProfile other) {
    if (identical(this, other)) return true;

    return other.isLoaded == isLoaded &&
        other.uid == uid &&
        other.email == email &&
        other.userName == userName;
  }

  @override
  int get hashCode {
    return isLoaded.hashCode ^
        uid.hashCode ^
        email.hashCode ^
        userName.hashCode;
  }
}

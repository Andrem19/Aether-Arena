// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountPlayerData {
  String name;
  String avatar;
  String rank;
  int level;
  AccountPlayerData({
    required this.name,
    required this.avatar,
    required this.rank,
    required this.level,
  });

  AccountPlayerData copyWith({
    String? name,
    String? avatar,
    String? rank,
    int? level,
  }) {
    return AccountPlayerData(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      rank: rank ?? this.rank,
      level: level ?? this.level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'rank': rank,
      'level': level,
    };
  }

  factory AccountPlayerData.fromMap(Map<String, dynamic> map) {
    return AccountPlayerData(
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      rank: map['rank'] as String,
      level: map['level'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountPlayerData.fromJson(String source) => AccountPlayerData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountPlayerData(name: $name, avatar: $avatar, rank: $rank, level: $level)';
  }

  @override
  bool operator ==(covariant AccountPlayerData other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.avatar == avatar &&
      other.rank == rank &&
      other.level == level;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      avatar.hashCode ^
      rank.hashCode ^
      level.hashCode;
  }
}

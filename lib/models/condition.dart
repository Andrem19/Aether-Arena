// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Condition {
  int RequiredLevel;
  List<WinnCondition> winnConditions;
  Condition({
    required this.RequiredLevel,
    required this.winnConditions,
  });

  Condition copyWith({
    int? RequiredLevel,
    List<WinnCondition>? winnConditions,
  }) {
    return Condition(
      RequiredLevel: RequiredLevel ?? this.RequiredLevel,
      winnConditions: winnConditions ?? this.winnConditions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'RequiredLevel': RequiredLevel,
      'winnConditions': winnConditions.map((x) => x.toMap()).toList(),
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      RequiredLevel: map['RequiredLevel'] as int,
      winnConditions: List<WinnCondition>.from((map['winnConditions'] as List<dynamic>).map<WinnCondition>((x) => WinnCondition.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Condition.fromJson(String source) => Condition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Condition(RequiredLevel: $RequiredLevel, winnConditions: $winnConditions)';

  @override
  bool operator ==(covariant Condition other) {
    if (identical(this, other)) return true;
  
    return 
      other.RequiredLevel == RequiredLevel &&
      listEquals(other.winnConditions, winnConditions);
  }

  @override
  int get hashCode => RequiredLevel.hashCode ^ winnConditions.hashCode;
}

class WinnCondition {
  bool ShouldBeContinuously;
  int count;
  List<int> mySet;
  WinnCondition({
    required this.ShouldBeContinuously,
    required this.count,
    required this.mySet,
  });

  WinnCondition copyWith({
    bool? ShouldBeContinuously,
    int? count,
    List<int>? mySet,
  }) {
    return WinnCondition(
      ShouldBeContinuously: ShouldBeContinuously ?? this.ShouldBeContinuously,
      count: count ?? this.count,
      mySet: mySet ?? this.mySet,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ShouldBeContinuously': ShouldBeContinuously,
      'count': count,
      'mySet': mySet,
    };
  }

  factory WinnCondition.fromMap(Map<String, dynamic> map) {
    return WinnCondition(
      ShouldBeContinuously: map['ShouldBeContinuously'] as bool,
      count: map['count'] as int,
      mySet: List<int>.from((map['mySet'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory WinnCondition.fromJson(String source) => WinnCondition.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WinnCondition(ShouldBeContinuously: $ShouldBeContinuously, count: $count, mySet: $mySet)';

  @override
  bool operator ==(covariant WinnCondition other) {
    if (identical(this, other)) return true;
  
    return 
      other.ShouldBeContinuously == ShouldBeContinuously &&
      other.count == count &&
      listEquals(other.mySet, mySet);
  }

  @override
  int get hashCode => ShouldBeContinuously.hashCode ^ count.hashCode ^ mySet.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonalSettings {
  bool adOff;
  PersonalSettings({
    required this.adOff,
  });
  static PersonalSettings getDefault() {
    return PersonalSettings(adOff: false);
  }

  PersonalSettings copyWith({
    bool? adOff,
  }) {
    return PersonalSettings(
      adOff: adOff ?? this.adOff,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adOff': adOff,
    };
  }

  factory PersonalSettings.fromMap(Map<String, dynamic> map) {
    return PersonalSettings(
      adOff: map['adOff'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalSettings.fromJson(String source) =>
      PersonalSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PersonalSettings(adOff: $adOff)';

  @override
  bool operator ==(covariant PersonalSettings other) {
    if (identical(this, other)) return true;

    return other.adOff == adOff;
  }

  @override
  int get hashCode => adOff.hashCode;
}

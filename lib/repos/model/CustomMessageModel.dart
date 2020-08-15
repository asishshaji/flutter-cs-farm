import 'dart:convert';

class CustomMessageModel {
  final String title;
  final String details;
  final String phoneNumber;

  CustomMessageModel(this.title, this.details, this.phoneNumber);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'details': details,
      'phoneNumber': phoneNumber,
    };
  }

  static CustomMessageModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CustomMessageModel(
      map['title'],
      map['details'],
      map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  static CustomMessageModel fromJson(String source) =>
      fromMap(json.decode(source));
}

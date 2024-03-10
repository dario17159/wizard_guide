import 'dart:convert';

import 'package:wizard_guide/src/core/enums/enums.dart';

class Gender {
  final String value;
  final GenderEnum type;

  Gender({
    required this.value,
    required this.type,
  });

  factory Gender.fromRawJson(String str) => Gender.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        value: json["value"],
        type: toGenderENUM[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "type": toGenderString[type],
      };
}

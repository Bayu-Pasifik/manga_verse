// To parse this JSON data, do
//
//     final recommended = recommendedFromJson(jsonString);

import 'dart:convert';

Recommended recommendedFromJson(String str) =>
    Recommended.fromJson(json.decode(str));

String recommendedToJson(Recommended data) => json.encode(data.toJson());

class Recommended {
  String? title;
  String? thumb;
  String? type;
  String? endpoint;

  Recommended({
    this.title,
    this.thumb,
    this.type,
    this.endpoint,
  });

  factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
        title: json["title"],
        thumb: json["thumb"],
        type: json["type"],
        endpoint: json["endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "type": type,
        "endpoint": endpoint,
      };
}

// To parse this JSON data, do
//
//     final recommended = recommendedFromJson(jsonString);

import 'dart:convert';

Recommended recommendedFromJson(String str) => Recommended.fromJson(json.decode(str));

String recommendedToJson(Recommended data) => json.encode(data.toJson());

class Recommended {
    String? title;
    String? thumb;
    String? endpoint;

    Recommended({
        this.title,
        this.thumb,
        this.endpoint,
    });

    factory Recommended.fromJson(Map<String, dynamic> json) => Recommended(
        title: json["title"],
        thumb: json["thumb"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "endpoint": endpoint,
    };
}

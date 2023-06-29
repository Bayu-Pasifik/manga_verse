// To parse this JSON data, do
//
//     final komikstationAll = komikstationAllFromJson(jsonString);

import 'dart:convert';

KomikstationAll komikstationAllFromJson(String str) => KomikstationAll.fromJson(json.decode(str));

String komikstationAllToJson(KomikstationAll data) => json.encode(data.toJson());

class KomikstationAll {
    String? title;
    String? thumbnail;
    String? latestChapter;
    String? endpoint;

    KomikstationAll({
        this.title,
        this.thumbnail,
        this.latestChapter,
        this.endpoint,
    });

    factory KomikstationAll.fromJson(Map<String, dynamic> json) => KomikstationAll(
        title: json["title"],
        thumbnail: json["thumbnail"],
        latestChapter: json["latestChapter"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "latestChapter": latestChapter,
        "endpoint": endpoint,
    };
}

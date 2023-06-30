// To parse this JSON data, do
//
//     final mangagekoAll = mangagekoAllFromJson(jsonString);

import 'dart:convert';

MangagekoAll mangagekoAllFromJson(String str) => MangagekoAll.fromJson(json.decode(str));

String mangagekoAllToJson(MangagekoAll data) => json.encode(data.toJson());

class MangagekoAll {
    String? title;
    String? author;
    String? lastUpdate;
    String? latestChapter;
    String? imageUrl;
    String? endpoint;

    MangagekoAll({
        this.title,
        this.author,
        this.lastUpdate,
        this.latestChapter,
        this.imageUrl,
        this.endpoint,
    });

    factory MangagekoAll.fromJson(Map<String, dynamic> json) => MangagekoAll(
        title: json["title"],
        author: json["author"],
        lastUpdate: json["LastUpdate"],
        latestChapter: json["latestChapter"],
        imageUrl: json["imageUrl"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "LastUpdate": lastUpdate,
        "latestChapter": latestChapter,
        "imageUrl": imageUrl,
        "endpoint": endpoint,
    };
}

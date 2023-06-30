// To parse this JSON data, do
//
//     final mangakalotAll = mangakalotAllFromJson(jsonString);

import 'dart:convert';

MangakalotAll mangakalotAllFromJson(String str) => MangakalotAll.fromJson(json.decode(str));

String mangakalotAllToJson(MangakalotAll data) => json.encode(data.toJson());

class MangakalotAll {
    String? title;
    String? chapter;
    String? views;
    String? thumbnail;
    String? endpoint;

    MangakalotAll({
        this.title,
        this.chapter,
        this.views,
        this.thumbnail,
        this.endpoint,
    });

    factory MangakalotAll.fromJson(Map<String, dynamic> json) => MangakalotAll(
        title: json["title"],
        chapter: json["chapter"],
        views: json["views"],
        thumbnail: json["thumbnail"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "chapter": chapter,
        "views": views,
        "thumbnail": thumbnail,
        "endpoint": endpoint,
    };
}

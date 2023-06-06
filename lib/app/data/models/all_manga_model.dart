// To parse this JSON data, do
//
//     final allMangaModel = allMangaModelFromJson(jsonString);

import 'dart:convert';

AllMangaModel allMangaModelFromJson(String str) => AllMangaModel.fromJson(json.decode(str));

String allMangaModelToJson(AllMangaModel data) => json.encode(data.toJson());

class AllMangaModel {
    String? title;
    String? thumbnail;
    String? latestChapter;
    String? endpoint;

    AllMangaModel({
        this.title,
        this.thumbnail,
        this.latestChapter,
        this.endpoint,
    });

    factory AllMangaModel.fromJson(Map<String, dynamic> json) => AllMangaModel(
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

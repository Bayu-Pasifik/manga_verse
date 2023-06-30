// To parse this JSON data, do
//
//     final mangakalotDetail = mangakalotDetailFromJson(jsonString);

import 'dart:convert';

MangakalotDetail mangakalotDetailFromJson(String str) => MangakalotDetail.fromJson(json.decode(str));

String mangakalotDetailToJson(MangakalotDetail data) => json.encode(data.toJson());

class MangakalotDetail {
    String? title;
    String? alternativeTitle;
    List<String>? authors;
    String? status;
    String? lastUpdates;
    String? views;
    List<String>? genres;
    String? cover;
    String? synopsis;
    List<Chapter>? chapters;

    MangakalotDetail({
        this.title,
        this.alternativeTitle,
        this.authors,
        this.status,
        this.lastUpdates,
        this.views,
        this.genres,
        this.cover,
        this.synopsis,
        this.chapters,
    });

    factory MangakalotDetail.fromJson(Map<String, dynamic> json) => MangakalotDetail(
        title: json["title"],
        alternativeTitle: json["alternativeTitle"],
        authors: json["authors"] == null ? [] : List<String>.from(json["authors"]!.map((x) => x)),
        status: json["status"],
        lastUpdates: json["lastUpdates"],
        views: json["views"],
        genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
        cover: json["cover"],
        synopsis: json["synopsis"],
        chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "alternativeTitle": alternativeTitle,
        "authors": authors == null ? [] : List<dynamic>.from(authors!.map((x) => x)),
        "status": status,
        "lastUpdates": lastUpdates,
        "views": views,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "cover": cover,
        "synopsis": synopsis,
        "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    };
}

class Chapter {
    String? chapterTitle;
    String? chapterUpload;
    String? chapterEndpoint;

    Chapter({
        this.chapterTitle,
        this.chapterUpload,
        this.chapterEndpoint,
    });

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterTitle: json["chapterTitle"],
        chapterUpload: json["chapterUpload"],
        chapterEndpoint: json["chapterEndpoint"],
    );

    Map<String, dynamic> toJson() => {
        "chapterTitle": chapterTitle,
        "chapterUpload": chapterUpload,
        "chapterEndpoint": chapterEndpoint,
    };
}

// To parse this JSON data, do
//
//     final detailManga = detailMangaFromJson(jsonString);

import 'dart:convert';

DetailManga detailMangaFromJson(String str) => DetailManga.fromJson(json.decode(str));

String detailMangaToJson(DetailManga data) => json.encode(data.toJson());

class DetailManga {
    String? title;
    String? altTitle;
    List<Genre>? genres;
    String? synopsis;
    String? thumbnail;
    List<Chapter>? chapters;
    String? status;
    String? type;
    String? released;
    String? author;
    String? postedBy;
    DateTime? postedOn;
    DateTime? updatedOn;
    String? views;
    String? rating;

    DetailManga({
        this.title,
        this.altTitle,
        this.genres,
        this.synopsis,
        this.thumbnail,
        this.chapters,
        this.status,
        this.type,
        this.released,
        this.author,
        this.postedBy,
        this.postedOn,
        this.updatedOn,
        this.views,
        this.rating,
    });

    factory DetailManga.fromJson(Map<String, dynamic> json) => DetailManga(
        title: json["title"],
        altTitle: json["altTitle"],
        genres: json["genres"] == null ? [] : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        synopsis: json["synopsis"],
        thumbnail: json["thumbnail"],
        chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
        status: json["status"],
        type: json["type"],
        released: json["released"],
        author: json["author"],
        postedBy: json["postedBy"],
        postedOn: json["postedOn"] == null ? null : DateTime.parse(json["postedOn"]),
        updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
        views: json["views"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "altTitle": altTitle,
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "synopsis": synopsis,
        "thumbnail": thumbnail,
        "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
        "status": status,
        "type": type,
        "released": released,
        "author": author,
        "postedBy": postedBy,
        "postedOn": postedOn?.toIso8601String(),
        "updatedOn": updatedOn?.toIso8601String(),
        "views": views,
        "rating": rating,
    };
}

class Chapter {
    String? name;
    String? date;
    String? endpoint;

    Chapter({
        this.name,
        this.date,
        this.endpoint,
    });

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        name: json["name"],
        date: json["date"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "endpoint": endpoint,
    };
}

class Genre {
    String? name;
    String? endpoint;

    Genre({
        this.name,
        this.endpoint,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        name: json["name"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "endpoint": endpoint,
    };
}

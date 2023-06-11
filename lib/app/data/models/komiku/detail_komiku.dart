// To parse this JSON data, do
//
//     final detailKomiku = detailKomikuFromJson(jsonString);

import 'dart:convert';

DetailKomiku detailKomikuFromJson(String str) => DetailKomiku.fromJson(json.decode(str));

String detailKomikuToJson(DetailKomiku data) => json.encode(data.toJson());

class DetailKomiku {
    String? title;
    String? type;
    String? author;
    String? status;
    String? views;
    String? mangaEndpoint;
    String? thumb;
    List<GenreList>? genreList;
    String? synopsis;
    List<Chapter>? chapter;

    DetailKomiku({
        this.title,
        this.type,
        this.author,
        this.status,
        this.views,
        this.mangaEndpoint,
        this.thumb,
        this.genreList,
        this.synopsis,
        this.chapter,
    });

    factory DetailKomiku.fromJson(Map<String, dynamic> json) => DetailKomiku(
        title: json["title"],
        type: json["type"],
        author: json["author"],
        status: json["status"],
        views: json["views"],
        mangaEndpoint: json["manga_endpoint"],
        thumb: json["thumb"],
        genreList: json["genre_list"] == null ? [] : List<GenreList>.from(json["genre_list"]!.map((x) => GenreList.fromJson(x))),
        synopsis: json["synopsis"],
        chapter: json["chapter"] == null ? [] : List<Chapter>.from(json["chapter"]!.map((x) => Chapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "author": author,
        "status": status,
        "views": views,
        "manga_endpoint": mangaEndpoint,
        "thumb": thumb,
        "genre_list": genreList == null ? [] : List<dynamic>.from(genreList!.map((x) => x.toJson())),
        "synopsis": synopsis,
        "chapter": chapter == null ? [] : List<dynamic>.from(chapter!.map((x) => x.toJson())),
    };
}

class Chapter {
    String? chapterTitle;
    String? chapterEndpoint;

    Chapter({
        this.chapterTitle,
        this.chapterEndpoint,
    });

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterTitle: json["chapter_title"],
        chapterEndpoint: json["chapter_endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "chapter_title": chapterTitle,
        "chapter_endpoint": chapterEndpoint,
    };
}

class GenreList {
    String? genreName;

    GenreList({
        this.genreName,
    });

    factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
        genreName: json["genre_name"],
    );

    Map<String, dynamic> toJson() => {
        "genre_name": genreName,
    };
}

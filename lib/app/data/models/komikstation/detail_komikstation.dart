// To parse this JSON data, do
//
//     final detailKomikstation = detailKomikstationFromJson(jsonString);

import 'dart:convert';

DetailKomikstation detailKomikstationFromJson(String str) =>
    DetailKomikstation.fromJson(json.decode(str));

String detailKomikstationToJson(DetailKomikstation data) =>
    json.encode(data.toJson());

class DetailKomikstation {
  String? title;
  String? altTitle;
  String? thumbnail;
  String? rating;
  String? status;
  String? type;
  String? ilustrator;
  String? synopsis;
  String? released;
  String? author;
  String? publisher;
  String? lastUpdate;
  List<String>? genres;
  List<Chapter>? chapters;

  DetailKomikstation({
    this.title,
    this.altTitle,
    this.thumbnail,
    this.rating,
    this.status,
    this.type,
    this.ilustrator,
    this.synopsis,
    this.released,
    this.author,
    this.publisher,
    this.lastUpdate,
    this.genres,
    this.chapters,
  });

  factory DetailKomikstation.fromJson(Map<String, dynamic> json) =>
      DetailKomikstation(
        title: json["title"],
        altTitle: json["altTitle"],
        thumbnail: json["thumbnail"],
        rating: json["rating"],
        status: json["status"],
        type: json["type"],
        ilustrator: json["ilustrator"],
        synopsis: json["synopsis"],
        released: json["released"],
        author: json["author"],
        publisher: json["publisher"],
        lastUpdate: json["lastUpdate"],
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"]!.map((x) => x)),
        chapters: json["chapters"] == null
            ? []
            : List<Chapter>.from(
                json["chapters"]!.map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "altTitle": altTitle,
        "thumbnail": thumbnail,
        "rating": rating,
        "status": status,
        "type": type,
        "ilustrator": ilustrator,
        "synopsis": synopsis,
        "released": released,
        "author": author,
        "publisher": publisher,
        "lastUpdate": lastUpdate,
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "chapters": chapters == null
            ? []
            : List<dynamic>.from(chapters!.map((x) => x.toJson())),
      };
}

class Chapter {
  String? chapterTitle;
  String? chapterRelease;
  String? chapterEndpoint;

  Chapter({
    this.chapterTitle,
    this.chapterRelease,
    this.chapterEndpoint,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterTitle: json["chapterTitle"],
        chapterRelease: json["chapterRelease"],
        chapterEndpoint: json["chapterEndpoint"],
      );

  Map<String, dynamic> toJson() => {
        "chapterTitle": chapterTitle,
        "chapterRelease": chapterRelease,
        "chapterEndpoint": chapterEndpoint,
      };
}

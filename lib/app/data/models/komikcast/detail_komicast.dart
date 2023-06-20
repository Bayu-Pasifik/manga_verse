// To parse this JSON data, do
//
//     final detailKomicast = detailKomicastFromJson(jsonString);

import 'dart:convert';

DetailKomicast detailKomicastFromJson(String str) =>
    DetailKomicast.fromJson(json.decode(str));

String detailKomicastToJson(DetailKomicast data) => json.encode(data.toJson());

class DetailKomicast {
  String? title;
  String? nativeTitle;
  String? imgeUrl;
  List<String>? genres;
  String? author;
  String? status;
  String? type;
  String? totalChapter;
  DateTime? updatedOn;
  String? rating;
  String? synopsis;
  List<ChapterList>? chapterList;

  DetailKomicast({
    this.title,
    this.nativeTitle,
    this.imgeUrl,
    this.genres,
    this.author,
    this.status,
    this.type,
    this.totalChapter,
    this.updatedOn,
    this.rating,
    this.synopsis,
    this.chapterList,
  });

  factory DetailKomicast.fromJson(Map<String, dynamic> json) => DetailKomicast(
        title: json["title"],
        nativeTitle: json["nativeTitle"],
        imgeUrl: json["imgeUrl"],
        genres: json["genres"] == null
            ? []
            : List<String>.from(json["genres"]!.map((x) => x)),
        author: json["author"],
        status: json["status"],
        type: json["type"],
        totalChapter: json["totalChapter"],
        updatedOn: json["updatedOn"] == null
            ? null
            : DateTime.parse(json["updatedOn"]),
        rating: json["rating"],
        synopsis: json["synopsis"],
        chapterList: json["chapterList"] == null
            ? []
            : List<ChapterList>.from(
                json["chapterList"]!.map((x) => ChapterList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "nativeTitle": nativeTitle,
        "imgeUrl": imgeUrl,
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "author": author,
        "status": status,
        "type": type,
        "totalChapter": totalChapter,
        "updatedOn": updatedOn?.toIso8601String(),
        "rating": rating,
        "synopsis": synopsis,
        "chapterList": chapterList == null
            ? []
            : List<dynamic>.from(chapterList!.map((x) => x.toJson())),
      };
}

class ChapterList {
  String? chapterTitle;
  String? chapterUrl;
  String? chapterTime;

  ChapterList({
    this.chapterTitle,
    this.chapterUrl,
    this.chapterTime,
  });

  factory ChapterList.fromJson(Map<String, dynamic> json) => ChapterList(
        chapterTitle: json["chapterTitle"],
        chapterUrl: json["chapterUrl"],
        chapterTime: json["chapterTime"],
      );

  Map<String, dynamic> toJson() => {
        "chapterTitle": chapterTitle,
        "chapterUrl": chapterUrl,
        "chapterTime": chapterTime,
      };
}

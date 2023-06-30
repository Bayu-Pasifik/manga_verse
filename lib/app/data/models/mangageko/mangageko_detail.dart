// To parse this JSON data, do
//
//     final detailMangageko = detailMangagekoFromJson(jsonString);

import 'dart:convert';

DetailMangageko detailMangagekoFromJson(String str) => DetailMangageko.fromJson(json.decode(str));

String detailMangagekoToJson(DetailMangageko data) => json.encode(data.toJson());

class DetailMangageko {
    String? title;
    String? alternativeTitle;
    String? author;
    String? description;
    String? thumbnails;
    String? lastUpdate;
    List<Header>? header;
    List<String>? listGenre;
    List<ListChapter>? listChapter;

    DetailMangageko({
        this.title,
        this.alternativeTitle,
        this.author,
        this.description,
        this.thumbnails,
        this.lastUpdate,
        this.header,
        this.listGenre,
        this.listChapter,
    });

    factory DetailMangageko.fromJson(Map<String, dynamic> json) => DetailMangageko(
        title: json["title"],
        alternativeTitle: json["alternativeTitle"],
        author: json["author"],
        description: json["description"],
        thumbnails: json["thumbnails"],
        lastUpdate: json["lastUpdate"],
        header: json["header"] == null ? [] : List<Header>.from(json["header"]!.map((x) => Header.fromJson(x))),
        listGenre: json["listGenre"] == null ? [] : List<String>.from(json["listGenre"]!.map((x) => x)),
        listChapter: json["listChapter"] == null ? [] : List<ListChapter>.from(json["listChapter"]!.map((x) => ListChapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "alternativeTitle": alternativeTitle,
        "author": author,
        "description": description,
        "thumbnails": thumbnails,
        "lastUpdate": lastUpdate,
        "header": header == null ? [] : List<dynamic>.from(header!.map((x) => x.toJson())),
        "listGenre": listGenre == null ? [] : List<dynamic>.from(listGenre!.map((x) => x)),
        "listChapter": listChapter == null ? [] : List<dynamic>.from(listChapter!.map((x) => x.toJson())),
    };
}

class Header {
    String? totalChapter;
    String? totalViews;
    String? status;

    Header({
        this.totalChapter,
        this.totalViews,
        this.status,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        totalChapter: json["totalChapter"],
        totalViews: json["totalViews"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "totalChapter": totalChapter,
        "totalViews": totalViews,
        "Status": status,
    };
}

class ListChapter {
    String? chapterNo;
    String? chapterUpdate;
    String? endpoint;

    ListChapter({
        this.chapterNo,
        this.chapterUpdate,
        this.endpoint,
    });

    factory ListChapter.fromJson(Map<String, dynamic> json) => ListChapter(
        chapterNo: json["chapterNo"],
        chapterUpdate: json["chapterUpdate"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "chapterNo": chapterNo,
        "chapterUpdate": chapterUpdate,
        "endpoint": endpoint,
    };
}

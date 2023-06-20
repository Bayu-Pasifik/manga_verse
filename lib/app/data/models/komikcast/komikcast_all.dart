// To parse this JSON data, do
//
//     final komikcastAll = komikcastAllFromJson(jsonString);

import 'dart:convert';

KomikcastAll komikcastAllFromJson(String str) => KomikcastAll.fromJson(json.decode(str));

String komikcastAllToJson(KomikcastAll data) => json.encode(data.toJson());

class KomikcastAll {
    String? title;
    String? chapter;
    String? type;
    String? numscore;
    String? imageUrl;
    String? endpoint;

    KomikcastAll({
        this.title,
        this.chapter,
        this.type,
        this.numscore,
        this.imageUrl,
        this.endpoint,
    });

    factory KomikcastAll.fromJson(Map<String, dynamic> json) => KomikcastAll(
        title: json["title"],
        chapter: json["chapter"],
        type: json["type"],
        numscore: json["numscore"],
        imageUrl: json["imageURL"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "chapter": chapter,
        "type": type,
        "numscore": numscore,
        "imageURL": imageUrl,
        "endpoint": endpoint,
    };
}

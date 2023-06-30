// To parse this JSON data, do
//
//     final mangakalotGenre = mangakalotGenreFromJson(jsonString);

import 'dart:convert';

MangakalotGenre mangakalotGenreFromJson(String str) => MangakalotGenre.fromJson(json.decode(str));

String mangakalotGenreToJson(MangakalotGenre data) => json.encode(data.toJson());

class MangakalotGenre {
    String? genreName;
    int? index;

    MangakalotGenre({
        this.genreName,
        this.index,
    });

    factory MangakalotGenre.fromJson(Map<String, dynamic> json) => MangakalotGenre(
        genreName: json["genreName"],
        index: json["index"],
    );

    Map<String, dynamic> toJson() => {
        "genreName": genreName,
        "index": index,
    };
}

// To parse this JSON data, do
//
//     final mangagekoGenre = mangagekoGenreFromJson(jsonString);

import 'dart:convert';

MangagekoGenre mangagekoGenreFromJson(String str) => MangagekoGenre.fromJson(json.decode(str));

String mangagekoGenreToJson(MangagekoGenre data) => json.encode(data.toJson());

class MangagekoGenre {
    String? genreName;
    String? endpoint;

    MangagekoGenre({
        this.genreName,
        this.endpoint,
    });

    factory MangagekoGenre.fromJson(Map<String, dynamic> json) => MangagekoGenre(
        genreName: json["genreName"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "genreName": genreName,
        "endpoint": endpoint,
    };
}

// To parse this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

GenreModel genreModelFromJson(String str) => GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
    String? genreName;
    String? endpoint;

    GenreModel({
        this.genreName,
        this.endpoint,
    });

    factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        genreName: json["genre_name"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "genre_name": genreName,
        "endpoint": endpoint,
    };
}

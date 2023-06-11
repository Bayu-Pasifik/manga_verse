// To parse this JSON data, do
//
//     final genreModel = genreModelFromJson(jsonString);

import 'dart:convert';

GenresModel genreModelFromJson(String str) => GenresModel.fromJson(json.decode(str));

String genreModelToJson(GenresModel data) => json.encode(data.toJson());

class GenresModel {
    String? genreName;
    String? endpoint;

    GenresModel({
        this.genreName,
        this.endpoint,
    });

    factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        genreName: json["genre_name"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "genre_name": genreName,
        "endpoint": endpoint,
    };
}

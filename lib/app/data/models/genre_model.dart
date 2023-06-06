// To parse this JSON data, do
//
//     final genreModel = trendingModelFromJson(jsonString);

import 'dart:convert';

GenreModel genreModelFromJson(String str) =>
    GenreModel.fromJson(json.decode(str));

String genreModelToJson(GenreModel data) => json.encode(data.toJson());

class GenreModel {
  String? name;
  String? endpoint;

  GenreModel({
    this.name,
    this.endpoint,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        name: json["name"],
        endpoint: json["endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "endpoint": endpoint,
      };
}

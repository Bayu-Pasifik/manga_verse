// To parse this JSON data, do
//
//     final genreKomicast = genreKomicastFromJson(jsonString);

import 'dart:convert';

GenreKomicast genreKomicastFromJson(String str) => GenreKomicast.fromJson(json.decode(str));

String genreKomicastToJson(GenreKomicast data) => json.encode(data.toJson());

class GenreKomicast {
    String? endpoint;
    String? genre;

    GenreKomicast({
        this.endpoint,
        this.genre,
    });

    factory GenreKomicast.fromJson(Map<String, dynamic> json) => GenreKomicast(
        endpoint: json["endpoint"],
        genre: json["genre"],
    );

    Map<String, dynamic> toJson() => {
        "endpoint": endpoint,
        "genre": genre,
    };
}

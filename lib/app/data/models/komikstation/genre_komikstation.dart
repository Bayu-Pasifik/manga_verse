// To parse this JSON data, do
//
//     final genreKomikstation = genreKomikstationFromJson(jsonString);

import 'dart:convert';

GenreKomikstation genreKomikstationFromJson(String str) => GenreKomikstation.fromJson(json.decode(str));

String genreKomikstationToJson(GenreKomikstation data) => json.encode(data.toJson());

class GenreKomikstation {
    String? name;
    String? endpoint;

    GenreKomikstation({
        this.name,
        this.endpoint,
    });

    factory GenreKomikstation.fromJson(Map<String, dynamic> json) => GenreKomikstation(
        name: json["name"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "endpoint": endpoint,
    };
}

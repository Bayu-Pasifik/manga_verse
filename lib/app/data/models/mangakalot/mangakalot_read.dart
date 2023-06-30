// To parse this JSON data, do
//
//     final mangakalotRead = mangakalotReadFromJson(jsonString);

import 'dart:convert';

MangakalotRead mangakalotReadFromJson(String str) => MangakalotRead.fromJson(json.decode(str));

String mangakalotReadToJson(MangakalotRead data) => json.encode(data.toJson());

class MangakalotRead {
    String? url;

    MangakalotRead({
        this.url,
    });

    factory MangakalotRead.fromJson(Map<String, dynamic> json) => MangakalotRead(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

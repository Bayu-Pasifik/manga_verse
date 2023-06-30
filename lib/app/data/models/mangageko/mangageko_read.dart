// To parse this JSON data, do
//
//     final readMangageko = readMangagekoFromJson(jsonString);

import 'dart:convert';

ReadMangageko readMangagekoFromJson(String str) => ReadMangageko.fromJson(json.decode(str));

String readMangagekoToJson(ReadMangageko data) => json.encode(data.toJson());

class ReadMangageko {
    String? chapterImage;
    String? chapterId;

    ReadMangageko({
        this.chapterImage,
        this.chapterId,
    });

    factory ReadMangageko.fromJson(Map<String, dynamic> json) => ReadMangageko(
        chapterImage: json["chapterImage"],
        chapterId: json["chapterId"],
    );

    Map<String, dynamic> toJson() => {
        "chapterImage": chapterImage,
        "chapterId": chapterId,
    };
}

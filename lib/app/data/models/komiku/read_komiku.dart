// To parse this JSON data, do
//
//     final readKomiku = readKomikuFromJson(jsonString);

import 'dart:convert';

ReadKomiku readKomikuFromJson(String str) => ReadKomiku.fromJson(json.decode(str));

String readKomikuToJson(ReadKomiku data) => json.encode(data.toJson());

class ReadKomiku {
    String? chapterImageLink;
    int? imageNumber;

    ReadKomiku({
        this.chapterImageLink,
        this.imageNumber,
    });

    factory ReadKomiku.fromJson(Map<String, dynamic> json) => ReadKomiku(
        chapterImageLink: json["chapter_image_link"],
        imageNumber: json["image_number"],
    );

    Map<String, dynamic> toJson() => {
        "chapter_image_link": chapterImageLink,
        "image_number": imageNumber,
    };
}

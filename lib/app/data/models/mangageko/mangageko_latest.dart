// To parse this JSON data, do
//
//     final mangagekoLatest = mangagekoLatestFromJson(jsonString);

import 'dart:convert';

MangagekoLatest mangagekoLatestFromJson(String str) => MangagekoLatest.fromJson(json.decode(str));

String mangagekoLatestToJson(MangagekoLatest data) => json.encode(data.toJson());

class MangagekoLatest {
    String? title;
    String? added;
    String? tag;
    String? imageUrl;
    String? endpoint;

    MangagekoLatest({
        this.title,
        this.added,
        this.tag,
        this.imageUrl,
        this.endpoint,
    });

    factory MangagekoLatest.fromJson(Map<String, dynamic> json) => MangagekoLatest(
        title: json["title"],
        added: json["added"],
        tag: json["tag"],
        imageUrl: json["imageUrl"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "added": added,
        "tag": tag,
        "imageUrl": imageUrl,
        "endpoint": endpoint,
    };
}

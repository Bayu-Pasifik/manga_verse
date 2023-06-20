// To parse this JSON data, do
//
//     final readKomicast = readKomicastFromJson(jsonString);

import 'dart:convert';

ReadKomicast readKomicastFromJson(String str) => ReadKomicast.fromJson(json.decode(str));

String readKomicastToJson(ReadKomicast data) => json.encode(data.toJson());

class ReadKomicast {
    int? index;
    String? url;

    ReadKomicast({
        this.index,
        this.url,
    });

    factory ReadKomicast.fromJson(Map<String, dynamic> json) => ReadKomicast(
        index: json["index"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "url": url,
    };
}

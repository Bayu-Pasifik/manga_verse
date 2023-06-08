// To parse this JSON data, do
//
//     final readModel = readModelFromJson(jsonString);

import 'dart:convert';

ReadModel readModelFromJson(String str) => ReadModel.fromJson(json.decode(str));

String readModelToJson(ReadModel data) => json.encode(data.toJson());

class ReadModel {
    dynamic index;
    String? url;

    ReadModel({
        this.index,
        this.url,
    });

    factory ReadModel.fromJson(Map<String, dynamic> json) => ReadModel(
        index: json["index"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "url": url,
    };
}

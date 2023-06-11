// To parse this JSON data, do
//
//     final komikuAll = komikuAllFromJson(jsonString);

import 'dart:convert';

KomikuAll komikuAllFromJson(String str) => KomikuAll.fromJson(json.decode(str));

String komikuAllToJson(KomikuAll data) => json.encode(data.toJson());

class KomikuAll {
    String? title;
    String? thumb;
    String? type;
    String? status;
    String? updatedOn;
    String? endpoint;

    KomikuAll({
        this.title,
        this.thumb,
        this.type,
        this.status,
        this.updatedOn,
        this.endpoint,
    });

    factory KomikuAll.fromJson(Map<String, dynamic> json) => KomikuAll(
        title: json["title"],
        thumb: json["thumb"],
        type: json["type"],
        status: json["status"],
        updatedOn: json["updated_on"],
        endpoint: json["endpoint"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "type": type,
        "status": status,
        "updated_on": updatedOn,
        "endpoint": endpoint,
    };
}

// To parse this JSON data, do
//
//     final readKomikstation = readKomikstationFromJson(jsonString);

import 'dart:convert';

ReadKomikstation readKomikstationFromJson(String str) =>
    ReadKomikstation.fromJson(json.decode(str));

String readKomikstationToJson(ReadKomikstation data) =>
    json.encode(data.toJson());

class ReadKomikstation {
  int? index;
  String? url;

  ReadKomikstation({
    this.index,
    this.url,
  });

  factory ReadKomikstation.fromJson(Map<String, dynamic> json) =>
      ReadKomikstation(
        index: json["index"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "url": url,
      };
}

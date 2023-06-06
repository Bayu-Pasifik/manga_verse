// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

TrendingModel trendingModelFromJson(String str) =>
    TrendingModel.fromJson(json.decode(str));

String trendingModelToJson(TrendingModel data) => json.encode(data.toJson());

class TrendingModel {
  String? title;
  String? thumbnail;
  String? endpoint;

  TrendingModel({
    this.title,
    this.thumbnail,
    this.endpoint,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
        title: json["title"],
        thumbnail: json["thumbnail"],
        endpoint: json["endpoint"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "endpoint": endpoint,
      };
}

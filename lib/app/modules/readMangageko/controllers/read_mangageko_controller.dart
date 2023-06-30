import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/mangageko/mangageko_read.dart';

class ReadMangagekoController extends GetxController {
   List<dynamic> allchapter = [];
  Future<List<dynamic>> getChapter(String endPoint) async {
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/mangageko/read/$endPoint');
    var response = await http.get(url);
    var data = json.decode(response.body)["chapterImage"];
    var tempData = data.map((e) => ReadMangageko.fromJson(e)).toList();
    allchapter.clear();
    allchapter.addAll(tempData);
    return allchapter;
  }
}

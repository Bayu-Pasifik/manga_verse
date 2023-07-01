import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/mangakalot/mangakalot_read.dart';

class ReadMangakalotController extends GetxController {
   List<dynamic> allchapter = [];
  Future<List<dynamic>> getChapter(String endPoint) async {
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/mangakalot/read/$endPoint');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => MangakalotRead.fromJson(e)).toList();
    allchapter.clear();
    allchapter.addAll(tempData);
    return allchapter;
  }
}

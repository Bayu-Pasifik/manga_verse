import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

class ReadKomikuController extends GetxController {
  List<dynamic> allchapter = [];
  Future<List<dynamic>> getChapter(String endPoint) async {
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/komiku/read/$endPoint');
    var response = await http.get(url);
    var data = json.decode(response.body)["chapter_image"];
    var tempData = data.map((e) => ReadKomiku.fromJson(e)).toList();
    allchapter.clear();
    allchapter.addAll(tempData);
    return allchapter;
  }
}

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/komikcast/read_komicast.dart';

class ReadKomicastController extends GetxController {
  List<dynamic> allchapter = [];
  Future<List<dynamic>> getChapter(String endPoint) async {
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/komikcast/read/$endPoint');
    var response = await http.get(url);
    var data = json.decode(response.body)["images"];
    var tempData = data.map((e) => ReadKomicast.fromJson(e)).toList();
    allchapter.clear();
    allchapter.addAll(tempData);
    return allchapter;
  }
}

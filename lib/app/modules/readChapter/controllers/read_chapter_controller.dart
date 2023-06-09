import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/read_model.dart';

class ReadChapterController extends GetxController {
  List<dynamic> allchapter = [];

  Future<List<dynamic>> getChapter(String endPoint) async {
    Uri url = Uri.parse(
        'https://manga-api.kolektifhost.com/api/komikstation/read/$endPoint');
    var response = await http.get(url);
    var data = json.decode(response.body)["images"];
    var tempData = List<ReadModel>.from(data.map((e) => ReadModel.fromJson(e)));

    // Clear the allchapter list before adding new data
    allchapter.clear();
    allchapter.addAll(tempData);
    return allchapter;
  }
}

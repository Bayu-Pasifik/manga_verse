import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/detail_model.dart';

class DetailMangaController extends GetxController {
  Future<dynamic> getDetail(String name) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/detail/$name');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempData = DetailManga.fromJson(data);
    return tempData;
  }
}

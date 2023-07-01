import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/mangakalot/mangakalot_detail.dart';

class DetailMangakalotController extends GetxController {
  Future<MangakalotDetail> getDetail(String name) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangakalot/detail/$name');
      var response = await http.get(url);
      var data = json.decode(response.body);
      var tempData = MangakalotDetail.fromJson(data);
      return tempData;
    } catch (error) {
      throw Exception('An error occurred');
    }
  }
}

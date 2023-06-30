import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/mangageko/mangageko_detail.dart';

class DetailMangagekoController extends GetxController {
  Future<DetailMangageko> getDetail(String name) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangageko/detail/$name');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var tempData = DetailMangageko.fromJson(data);
        return tempData;
      } else {
        throw Exception('Failed to get data from server');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('An error occurred');
    }
  }
}

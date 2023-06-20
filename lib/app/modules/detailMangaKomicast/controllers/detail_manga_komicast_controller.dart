import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/komikcast/detail_komicast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailMangaKomicastController extends GetxController {
  Future<DetailKomicast> getDetail(String name) async {
    try {
      Uri url = Uri.parse('http://10.0.2.2:8080/api/detail/$name');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var tempData = DetailKomicast.fromJson(data);
        print(tempData.status);
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

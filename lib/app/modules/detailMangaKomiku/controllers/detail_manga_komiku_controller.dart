import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';

class DetailMangaKomikuController extends GetxController {
  Future<DetailKomiku> getDetail(String name) async {
    try {
      Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/komiku/detail/$name');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var tempData = DetailKomiku.fromJson(data);
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

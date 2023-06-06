import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var currentIndex = 1.obs;

  Future<List<dynamic>> popularManga() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/popular');
    var response = await http.get(url);
    var data = json.decode(response.body)["manhwas"];
    var tempData = data.map((e) => TrendingModel.fromJson(e)).toList();
    // debugPrint(tempData.title);
    return tempData;
  }
}

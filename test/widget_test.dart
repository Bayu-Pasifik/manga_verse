import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/detail_model.dart';

void main() async {
  Uri url = Uri.parse('http://localhost:8000/detail/99-wooden-stick');
  var response = await http.get(url);
  var data = json.decode(response.body)["manhwa"];
  var tempData = data.map((e) => DetailManga.fromJson(e));
  print(tempData);
}

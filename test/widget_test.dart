import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:manga_verse/app/data/models/detail_model.dart';
import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse('http://localhost:8000/read/99-wooden-stick-chapter-67/');
  var response = await http.get(url);
  var data = json.decode(response.body)["images"];
  var tempData = data.map((e) => ReadModel.fromJson(e)).toList();
  print(tempData.length);
}

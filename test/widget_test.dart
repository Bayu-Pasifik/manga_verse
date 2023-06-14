import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/all_manga_model.dart';
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

// import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse('http://localhost:8000/genres/1/68');
  var response = await http.get(url);
  var data = json.decode(response.body)["manhwas"];

  var tempData = data.map((e) => AllMangaModel.fromJson(e)).toList();

  print(tempData[0].thumbnail);
  // print(tempData);
}

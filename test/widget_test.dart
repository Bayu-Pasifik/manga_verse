import 'package:http/http.dart' as http;
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse('http://localhost:3000/manga/detail/one-piece');
  var response = await http.get(url);
  var data = json.decode(response.body);
  // var tempData = DetailKomiku.fromJson(data);
  print(data);
}

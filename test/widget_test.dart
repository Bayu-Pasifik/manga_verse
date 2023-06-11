import 'package:http/http.dart' as http;
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
// import 'dart:convert';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse('http://localhost:3000/recommended');
  var response = await http.get(url);
  // var data = json.decode(response.body)["manga_list"];
  // var tempData = data.map((e) => Recommended.fromJson(e)).toList();
  // return tempData;
  print(response.body);
}

import 'package:http/http.dart' as http;
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

// import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse(
      'http://localhost:3000/api/chapter/aoppella-hajimari-no-playlist-chapter-9/');
  var response = await http.get(url);
  var data = json.decode(response.body)["chapter_image"];

  var tempData = data.map((e) => ReadKomiku.fromJson(e)).toList();

  print(tempData[0].chapterImageLink);
}

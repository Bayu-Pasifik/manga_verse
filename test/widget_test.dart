import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';
import 'package:manga_verse/app/data/models/komikcast/read_komicast.dart';
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

// import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse(
      'http://127.0.0.1:8080/api/read/kimetsu-no-yaiba-chapter-205-bahasa-indonesia/');
  var response = await http.get(url);
  var data = json.decode(response.body)["images"];
  var tempData = data.map((e) => ReadKomicast.fromJson(e));
  print(tempData);
}

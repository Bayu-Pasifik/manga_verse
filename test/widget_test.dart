import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';
import 'package:manga_verse/app/data/models/komikcast/read_komicast.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

// import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url =
      Uri.parse('https://manga-api.kolektifhost.com/api/komiku/all/1');
  var response = await http.get(url);
  var tempData = json.decode(response.body)["manga_list"];
  print(tempData);
  // var data = tempData.map((e) => KomikuAll.fromJson(e)).toList();
  // List<KomikuAll> allLatest = List<KomikuAll>.from(data);
}

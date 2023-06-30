import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';
import 'package:manga_verse/app/data/models/komikcast/read_komicast.dart';
import 'package:manga_verse/app/data/models/komikstation/komikstation_all.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
// import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

// import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
// import 'package:manga_verse/app/data/models/read_model.dart';

void main() async {
  Uri url = Uri.parse(
      'https://manga-api.kolektifhost.com/api/komikstation/genres/action/1');
  var response = await http.get(url);
  var data = json.decode(response.body)["manga"];
  // next.value = json.decode(response.body)["next"];
  // var tempData = data.map((e) => KomikstationAll.fromJson(e)).toList();
  // allManga.addAll(tempData);
  // print(allManga[0].latestChapter);
  print(data);
}

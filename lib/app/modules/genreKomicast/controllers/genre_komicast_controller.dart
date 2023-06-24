import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreKomicastController extends GetxController {
  var isGrid = false.obs;

  void gridMode() {
    isGrid.toggle();
    update();
  }

  String greeting() {
    var hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return "Selamat pagi";
    } else if (hour >= 12 && hour < 15) {
      return "Selamat siang";
    } else if (hour >= 15 && hour < 18) {
      return "Selamat sore";
    } else {
      return "Selamat malam";
    }
  }

  RefreshController allRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  List<dynamic> allManga = [];
  var next = true.obs;

  Future<List<dynamic>> getMangaBaseGenre(String genre) async {
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/komikcast/genre/$genre/$hal');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    next.value = json.decode(response.body)["next"];
    var tempData = data.map((e) => KomikcastAll.fromJson(e)).toList();
    allManga.addAll(tempData);
    return allManga;
  }

  void refreshData(String genres) async {
    if (allRefresh.initialRefresh == true) {
      hal.value = 1;
      allManga.clear();
      await getMangaBaseGenre(genres);
      update();
      return allRefresh.refreshCompleted();
    } else {
      return allRefresh.refreshFailed();
    }
  }

  void loadData(String genres) async {
    if (next.value == true) {
      hal.value = hal.value + 1;
      await getMangaBaseGenre(genres);
      update();
      return allRefresh.loadComplete();
    } else {
      return allRefresh.loadNoData();
    }
  }
}

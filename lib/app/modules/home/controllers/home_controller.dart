import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/data/models/genre_model.dart';
import 'package:manga_verse/app/data/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  // ! Greating

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

  var currentIndex = 0.obs;

  Future<List<dynamic>> popularManga() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/popular');
    var response = await http.get(url);
    var data = json.decode(response.body)["manhwas"];
    var tempData = data.map((e) => TrendingModel.fromJson(e)).toList();
    // debugPrint(tempData.title);
    return tempData;
  }

  // ! semua Manga

  RefreshController allRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  List<dynamic> allManga = [];
  var next = true.obs;

  Future<List<dynamic>> getmanga(int page) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/all/$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    next.value = json.decode(response.body)["next"];
    var tempData = data.map((e) => AllMangaModel.fromJson(e)).toList();
    allManga.addAll(tempData);
    print(tempData);
    return allManga;
  }

  void refreshData(int id) async {
    if (allRefresh.initialRefresh == true) {
      hal.value = 1;
      allManga.clear();
      await getmanga(hal.value);
      update();
      return allRefresh.refreshCompleted();
    } else {
      return allRefresh.refreshFailed();
    }
  }

  void loadData(int id) async {
    if (next.value == true) {
      hal.value = hal.value + 1;
      await getmanga(hal.value);
      update();
      return allRefresh.loadComplete();
    } else {
      return allRefresh.loadNoData();
    }
  }
  // ! Latest Manga

  RefreshController latestRefresh = RefreshController(initialRefresh: true);
  var halupdate = 1.obs;
  List<dynamic> latest = [];
  var nextupdate = true.obs;

  Future<List<dynamic>> getLatest(int page) async {
    Uri url = Uri.parse('http://10.0.2.2:8000/latest/$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    next.value = json.decode(response.body)["next"];
    var tempData = data.map((e) => AllMangaModel.fromJson(e)).toList();
    latest.addAll(tempData);
    print(tempData);
    return latest;
  }

  void refreshUpdate(int id) async {
    if (latestRefresh.initialRefresh == true) {
      halupdate.value = 1;
      latest.clear();
      await getLatest(halupdate.value);
      update();
      return latestRefresh.refreshCompleted();
    } else {
      return latestRefresh.refreshFailed();
    }
  }

  void loadUpdate(int id) async {
    if (nextupdate.value == true) {
      halupdate.value = halupdate.value + 1;
      await getLatest(halupdate.value);
      update();
      return latestRefresh.loadComplete();
    } else {
      return latestRefresh.loadNoData();
    }
  }

  // ! List Genre

  Future<List<dynamic>> listGenre() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/genre');
    var response = await http.get(url);
    var data = json.decode(response.body)["genres"];
    var tempData = data.map((e) => GenreModel.fromJson(e)).toList();
    return tempData;
  }
}

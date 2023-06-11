import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/genre_model.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/recomended.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KomikuHomeController extends GetxController {
  var currentIndex = 0.obs;
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

  Future<List<dynamic>> popularManga() async {
    Uri url = Uri.parse('http://10.0.2.2:3000/api/recommended');
    var response = await http.get(url);
    var data = json.decode(response.body)["manga_list"];
    var tempData = data.map((e) => Recommended.fromJson(e)).toList();
    return tempData;
  }
  // ! semua Manga

  RefreshController allRefresh = RefreshController(initialRefresh: true);
  var hal = 1.obs;
  List<dynamic> allManga = [];
  var next = true.obs;

  Future<List<dynamic>> getmanga(int page) async {
    Uri url = Uri.parse('http://10.0.2.2:3000/api/manga?page=$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["manga_list"];
    next.value = json.decode(response.body)["hasNextPage"];
    var tempData = data.map((e) => KomikuAll.fromJson(e)).toList();
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
    Uri url = Uri.parse('http://10.0.2.2:3000/api/manga/popular/$page');
    var response = await http.get(url);
    var data = json.decode(response.body)["manga_list"];
    next.value = json.decode(response.body)["hasNextPage"];
    var tempData = data.map((e) => KomikuAll.fromJson(e)).toList();
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
    Uri url = Uri.parse('http://10.0.2.2:3000/genres');
    var response = await http.get(url);
    var data = json.decode(response.body)["list_genre"];
    var tempData = data.map((e) => GenreModel.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga

  late TextEditingController searchController;
  var nextSearch = true.obs;
  RefreshController searchRefresh = RefreshController(initialRefresh: true);
  var halSearch = 1.obs;
  List<dynamic> allSearch = [];
  Future<List<dynamic>> getSearch(String keyword) async {
    Uri url = Uri.parse('http://10.0.2.2:3000/api/search/$keyword/$halSearch');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    nextSearch.value = json.decode(response.body)["next"];
    update();
    var tempData = data.map((e) => KomikuAll.fromJson(e)).toList();
    update();
    allSearch.addAll(tempData);
    update();
    print(tempData);
    return latest;
  }

  void refreshSearch(String query) async {
    if (searchRefresh.initialRefresh == true) {
      halSearch.value = 1;
      allSearch.clear();
      await getSearch(query);
      update();
      return searchRefresh.refreshCompleted();
    } else {
      return searchRefresh.refreshFailed();
    }
  }

  void loadSearch(String query) async {
    if (nextupdate.value == true) {
      halSearch.value = halupdate.value + 1;
      await getSearch(query);
      update();
      return searchRefresh.loadComplete();
    } else {
      return searchRefresh.loadNoData();
    }
  }

  void clearSearch() {
    halSearch.value = 1;
    update();
    allSearch.clear();
  }

  @override
  void onInit() {
    super.onInit();
    searchController = SearchController();
    // searchController.text = "naruto";
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}

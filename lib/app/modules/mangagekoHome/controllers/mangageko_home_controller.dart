import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/mangageko/mangageko_all.dart';
import 'package:manga_verse/app/data/models/mangageko/mangageko_genre.dart';
import 'package:manga_verse/app/data/models/mangageko/mangageko_latest.dart';
import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangagekoHomeController extends GetxController {
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
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/mangageko/new');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => MangagekoAll.fromJson(e)).toList();
    return tempData;
  }
  // ! semua Manga

  final PagingController<int, MangagekoAll> allmangaController =
      PagingController<int, MangagekoAll>(firstPageKey: 1);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangageko/all/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => MangagekoAll.fromJson(e)).toList();
      List<MangagekoAll> allMangaData = List<MangagekoAll>.from(data);
      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;

      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        allmangaController.appendLastPage(allMangaData);
      } else {
        allmangaController.appendPage(allMangaData, pageKey + 1);
      }
    } catch (e) {
      allmangaController.error = e;
    }
  }

  // ! Latest Manga

  final PagingController<int, MangagekoLatest> allLatestManga =
      PagingController<int, MangagekoLatest>(firstPageKey: 1);

  void getLatest(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangageko/latest/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => MangagekoLatest.fromJson(e)).toList();
      List<MangagekoLatest> allLatest = List<MangagekoLatest>.from(data);

      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;

      if (isLastPage) {
        Get.snackbar("Error", "No more data");
        allLatestManga.appendLastPage(allLatest);
      } else {
        allLatestManga.appendPage(allLatest, pageKey + 1);
      }
    } catch (e) {
      allLatestManga.error = e;
    }
  }

  // ! List Genre

  Future<List<dynamic>> listGenre() async {
    Uri url =
        Uri.parse('https://manga-api.kolektifhost.com/api/mangageko/genres');
    var response = await http.get(url);
    var data = json.decode(response.body)["list_genre"];
    var tempData = data.map((e) => MangagekoGenre.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga

  late TextEditingController searchController;
  var nextSearch = true.obs;
  RefreshController searchRefresh = RefreshController(initialRefresh: true);
  var halSearch = 1.obs;
  List<dynamic> allSearch = [];
  Future<List<dynamic>> getSearch(String keyword) async {
    Uri url = Uri.parse(
        'https://manga-api.kolektifhost.com/api/mangageko/search/$keyword/$halSearch');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    nextSearch.value = json.decode(response.body)["next"];
    update();
    var tempData = data.map((e) => MangagekoAll.fromJson(e)).toList();
    update();
    allSearch.addAll(tempData);
    update();
    return allSearch;
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
    if (nextSearch.value == true) {
      halSearch.value = halSearch.value + 1;
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
    allmangaController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    allLatestManga.addPageRequestListener((pageKey) {
      getLatest(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    allLatestManga.dispose();
    allmangaController.dispose();
  }
}

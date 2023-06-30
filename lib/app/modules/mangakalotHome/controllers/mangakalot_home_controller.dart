import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/mangakalot/mangakalot_all.dart';
import 'package:manga_verse/app/data/models/mangakalot/mangakalot_genre.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MangakalotHomeController extends GetxController {
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
    Uri url =
        Uri.parse('https://manga-api.kolektifhost.com/api/mangakalot/popular');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => MangakalotAll.fromJson(e)).toList();
    return tempData;
  }
  // ! semua Manga

  final PagingController<int, MangakalotAll> allmangaController =
      PagingController<int, MangakalotAll>(firstPageKey: 1);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangakalot/latest/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => MangakalotAll.fromJson(e)).toList();
      List<MangakalotAll> allMangaData = List<MangakalotAll>.from(data);
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

  final PagingController<int, MangakalotAll> allLatestManga =
      PagingController<int, MangakalotAll>(firstPageKey: 1);

  void getLatest(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/mangakalot/completed/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => MangakalotAll.fromJson(e)).toList();
      List<MangakalotAll> allLatest = List<MangakalotAll>.from(data);

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
        Uri.parse('https://manga-api.kolektifhost.com/api/mangakalot/genres');
    var response = await http.get(url);
    var data = json.decode(response.body)["list_genre"];
    var tempData = data.map((e) => MangakalotGenre.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga
  late TextEditingController searchController;
  List<MangakalotAll> listSearch = [];
  RefreshController searchRefresh = RefreshController();
  RxBool isSearchResultsLoaded = false.obs;
  RxBool isSearch = false.obs;

  void setSearchResultsLoaded(bool value) {
    isSearchResultsLoaded.value = value;
  }

  void setIsSearching(bool value) {
    isSearch.value = value;
  }

  final PagingController<int, MangakalotAll> searchMangaController =
      PagingController<int, MangakalotAll>(firstPageKey: 1);

  void searchMangaAPI(String keyword, int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikstation/search/$keyword/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      print("data search:$tempData");
      var data = tempData.map((e) => MangakalotAll.fromJson(e)).toList();
      List<MangakalotAll> listSearch = List<MangakalotAll>.from(data);

      final nextPage = json.decode(response.body)["next"];
      final isLastPage = nextPage == false;

      if (isLastPage) {
        searchMangaController.appendLastPage(listSearch);
      } else {
        searchMangaController.appendPage(listSearch, pageKey + 1);
      }
    } catch (e) {
      searchMangaController.error = e;
    }
  }

  void clearSearch() {
    listSearch.clear();
  }

  @override
  void dispose() {
    super.dispose();
    allLatestManga.dispose();
    allmangaController.dispose();
    searchController.dispose();
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
    searchMangaController.addPageRequestListener((pageKey) {
      searchMangaAPI(searchController.text, pageKey);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_verse/app/data/models/komiku/genres_model.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
import 'dart:convert';

import 'package:manga_verse/app/data/models/komiku/recomended.dart';

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
    Uri url =
        Uri.parse('https://manga-api.kolektifhost.com/api/komiku/recommended');
    var response = await http.get(url);
    var data = json.decode(response.body)["manga_list"];
    var tempData = data.map((e) => Recommended.fromJson(e)).toList();
    return tempData;
  }
  // ! semua Manga

  final PagingController<int, KomikuAll> allmangaController =
      PagingController<int, KomikuAll>(firstPageKey: 1);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komiku/all/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["manga_list"];
      var data = tempData.map((e) => KomikuAll.fromJson(e)).toList();
      List<KomikuAll> allMangaData = List<KomikuAll>.from(data);
      final nextPage = json.decode(response.body)["hasNextPage"];
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

  final PagingController<int, KomikuAll> allLatestManga =
      PagingController<int, KomikuAll>(firstPageKey: 1);

  void getLatest(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komiku/popular/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["manga_list"];
      var data = tempData.map((e) => KomikuAll.fromJson(e)).toList();
      List<KomikuAll> allLatest = List<KomikuAll>.from(data);

      final nextPage = json.decode(response.body)["hasNextPage"];
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
    Uri url = Uri.parse('https://manga-api.kolektifhost.com/api/komiku/genres');
    var response = await http.get(url);
    var data = json.decode(response.body)["list_genre"];
    var tempData = data.map((e) => GenresModel.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga

  late TextEditingController searchController;
  List<KomikuAll> listSearch = [];
  RxBool isSearchResultsLoaded = false.obs;
  RxBool isSearch = false.obs;

  void setSearchResultsLoaded(bool value) {
    isSearchResultsLoaded.value = value;
  }

  void setIsSearching(bool value) {
    isSearch.value = value;
  }

  final PagingController<int, KomikuAll> searchMangaController =
      PagingController<int, KomikuAll>(firstPageKey: 1);

  void searchMangaAPI(String keyword, int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komiku/search/$keyword/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["manga_list"];
      var data = tempData.map((e) => KomikuAll.fromJson(e)).toList();
      listSearch = List<KomikuAll>.from(data);
      final nextPage = json.decode(response.body)["hasNextPage"];
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
    searchMangaController.itemList?.clear();
    searchMangaController.firstPageKey;
    searchMangaController.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    allLatestManga.dispose();
    allmangaController.dispose();
    searchController.dispose();
    searchMangaController.dispose();
  }

  @override
  void onClose() {
    super.onClose();
    allLatestManga.dispose();
    allmangaController.dispose();
    searchController.dispose();
    searchMangaController.dispose();
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

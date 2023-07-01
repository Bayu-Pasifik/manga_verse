import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_verse/app/data/models/komikcast/genre_komicast.dart';
import 'dart:convert';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';

class KomicastHomeController extends GetxController {
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
    Uri url = Uri.parse(
        'https://manga-api.kolektifhost.com/api/komikcast/popular/1'); // Perbarui URL dengan menambahkan direktori 'api'
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => KomikcastAll.fromJson(e)).toList();
    return tempData;
  }

  // ! semua Manga

  final PagingController<int, KomikcastAll> allmangaController =
      PagingController<int, KomikcastAll>(firstPageKey: 1);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikcast/all/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikcastAll.fromJson(e)).toList();
      List<KomikcastAll> allMangaData = List<KomikcastAll>.from(data);

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

  final PagingController<int, KomikcastAll> allLatestManga =
      PagingController<int, KomikcastAll>(firstPageKey: 1);

  void getLatest(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikcast/latest/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikcastAll.fromJson(e)).toList();
      List<KomikcastAll> allLatest = List<KomikcastAll>.from(data);

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
        Uri.parse('https://manga-api.kolektifhost.com/api/komikcast/genre');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => GenreKomicast.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga

  final PagingController<int, KomikcastAll> searchMangaController =
      PagingController<int, KomikcastAll>(firstPageKey: 1);
  RxBool isSearchResultsLoaded = false.obs;
  RxBool isSearch = false.obs;

  void setSearchResultsLoaded(bool value) {
    isSearchResultsLoaded.value = value;
  }

  void setIsSearching(bool value) {
    isSearch.value = value;
  }

  void searchMangaAPI(String keyword, int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikcast/search/$keyword/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikcastAll.fromJson(e)).toList();
      List<KomikcastAll> listSearch = List<KomikcastAll>.from(data);

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

  late TextEditingController searchController;

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

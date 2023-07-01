import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_verse/app/data/models/genre_model.dart';
import 'package:http/http.dart' as http;
import 'package:manga_verse/app/data/models/komikstation/komikstation_all.dart';
import 'dart:convert';



class HomeController extends GetxController {
  // ! Greting

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
        'https://manga-api.kolektifhost.com/api/komikstation/popular/1');
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    var tempData = data.map((e) => KomikstationAll.fromJson(e)).toList();
    return tempData;
  }

  // ! semua Manga

  final PagingController<int, KomikstationAll> allmangaController =
      PagingController<int, KomikstationAll>(firstPageKey: 114);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikstation/all/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikstationAll.fromJson(e)).toList();
      List<KomikstationAll> allMangaData = List<KomikstationAll>.from(data);

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

  final PagingController<int, KomikstationAll> allLatestManga =
      PagingController<int, KomikstationAll>(firstPageKey: 1);

  void getLatest(int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikstation/completed/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikstationAll.fromJson(e)).toList();
      List<KomikstationAll> allLatest = List<KomikstationAll>.from(data);

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
        Uri.parse('https://manga-api.kolektifhost.com/api/komikstation/genres');
    var response = await http.get(url);
    var data = json.decode(response.body)["genres"];
    var tempData = data.map((e) => GenreModel.fromJson(e)).toList();
    return tempData;
  }

  // ! search manga

  final PagingController<int, KomikstationAll> searchMangaController =
      PagingController<int, KomikstationAll>(firstPageKey: 1);

  void searchMangaAPI(String keyword, int pageKey) async {
    try {
      Uri url = Uri.parse(
          'https://manga-api.kolektifhost.com/api/komikstation/search/$keyword/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      print("data search:$tempData");
      var data = tempData.map((e) => KomikstationAll.fromJson(e)).toList();
      List<KomikstationAll> listSearch = List<KomikstationAll>.from(data);

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

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
        'http://10.0.2.2:8080/api/popular/1'); // Perbarui URL dengan menambahkan direktori 'api'
    var response = await http.get(url);
    var data = json.decode(response.body)["data"];
    print(data);
    var tempData = data.map((e) => KomikcastAll.fromJson(e)).toList();
    return tempData;
  }

  // ! semua Manga

  final PagingController<int, KomikcastAll> allmangaController =
      PagingController<int, KomikcastAll>(firstPageKey: 1);

  void fetchData(int pageKey) async {
    try {
      Uri url = Uri.parse('http://10.0.2.2:8080/api/all/$pageKey');
      var response = await http.get(url);
      var tempData = json.decode(response.body)["data"];
      var data = tempData.map((e) => KomikcastAll.fromJson(e)).toList();
      print("Data dari fetchData all $data");
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
      Uri url = Uri.parse('http://10.0.2.2:8080/api/latest/$pageKey');
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

  // Future<List<dynamic>> listGenre() async {
  //   Uri url = Uri.parse('http://10.0.2.2:8000/genres');
  //   var response = await http.get(url);
  //   var data = json.decode(response.body)["genres"];
  //   var tempData = data.map((e) => GenreModel.fromJson(e)).toList();
  //   return tempData;
  // }

  // ! search manga

  // final PagingController<int, AllMangaModel> searchManga =
  //     PagingController<int, AllMangaModel>(firstPageKey: 1);

  // void searchMangaAPI(String keyword, int pageKey) async {
  //   try {
  //     Uri url = Uri.parse('http://10.0.2.2:8000/search/$keyword/$pageKey');
  //     var response = await http.get(url);
  //     var tempData = json.decode(response.body)["data"];
  //     var data = tempData.map((e) => AllMangaModel.fromJson(e)).toList();
  //     List<AllMangaModel> allLatest = List<AllMangaModel>.from(data);

  //     final nextPage = json.decode(response.body)["next"];
  //     final isLastPage = nextPage == false;

  //     if (isLastPage) {
  //       Get.snackbar("Error", "No more data");
  //       allLatestManga.appendLastPage(allLatest);
  //     } else {
  //       allLatestManga.appendPage(allLatest, pageKey + 1);
  //     }
  //   } catch (e) {
  //     allLatestManga.error = e;
  //   }
  // }

  // late TextEditingController searchController;
  // var nextSearch = true.obs;
  // RefreshController searchRefresh = RefreshController(initialRefresh: true);
  // var halSearch = 1.obs;
  // List<dynamic> allSearch = [];
  // Future<List<dynamic>> getSearch(String keyword) async {
  //   Uri url = Uri.parse('http://10.0.2.2:8000/search/$keyword/$halSearch');
  //   var response = await http.get(url);
  //   var data = json.decode(response.body)["data"];
  //   nextSearch.value = json.decode(response.body)["next"];
  //   update();
  //   var tempData = data.map((e) => AllMangaModel.fromJson(e)).toList();
  //   update();
  //   allSearch.addAll(tempData);
  //   update();
  //   print("data dari search : ${tempData.length}");
  //   return allSearch;
  // }

  // void refreshSearch(String query) async {
  //   if (searchRefresh.initialRefresh == true) {
  //     halSearch.value = 1;
  //     allSearch.clear();
  //     await getSearch(query);
  //     update();
  //     return searchRefresh.refreshCompleted();
  //   } else {
  //     return searchRefresh.refreshFailed();
  //   }
  // }

  // void loadSearch(String query) async {
  //   if (nextSearch.value == true) {
  //     halSearch.value = halSearch.value + 1;
  //     await getSearch(query);
  //     update();
  //     return searchRefresh.loadComplete();
  //   } else {
  //     return searchRefresh.loadNoData();
  //   }
  // }

  // void clearSearch() {
  //   halSearch.value = 1;
  //   update();
  //   allSearch.clear();
  // }

  @override
  void dispose() {
    super.dispose();
    // allLatestManga.dispose();
    allmangaController.dispose();
    // searchController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    // searchController = SearchController();
    allmangaController.addPageRequestListener((pageKey) {
      fetchData(pageKey);
    });
    allLatestManga.addPageRequestListener((pageKey) {
      getLatest(pageKey);
    });
  }
}

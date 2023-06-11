import 'package:get/get.dart';

import '../modules/detailManga/bindings/detail_manga_binding.dart';
import '../modules/detailManga/views/detail_manga_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/komikuHome/bindings/komiku_home_binding.dart';
import '../modules/komikuHome/views/komiku_home_view.dart';
import '../modules/readChapter/bindings/read_chapter_binding.dart';
import '../modules/readChapter/views/read_chapter_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MANGA,
      page: () => const DetailMangaView(),
      binding: DetailMangaBinding(),
    ),
    GetPage(
      name: _Paths.READ_CHAPTER,
      page: () => const ReadChapterView(),
      binding: ReadChapterBinding(),
    ),
    GetPage(
      name: _Paths.KOMIKU_HOME,
      page: () =>  KomikuHomeView(),
      binding: KomikuHomeBinding(),
    ),
  ];
}

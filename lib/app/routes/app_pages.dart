import 'package:get/get.dart';

import '../modules/detailManga/bindings/detail_manga_binding.dart';
import '../modules/detailManga/views/detail_manga_view.dart';
import '../modules/detailMangaKomiku/bindings/detail_manga_komiku_binding.dart';
import '../modules/detailMangaKomiku/views/detail_manga_komiku_view.dart';
import '../modules/genreKomiku/bindings/genre_komiku_binding.dart';
import '../modules/genreKomiku/views/genre_komiku_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/komikuHome/bindings/komiku_home_binding.dart';
import '../modules/komikuHome/views/komiku_home_view.dart';
import '../modules/readChapter/bindings/read_chapter_binding.dart';
import '../modules/readChapter/views/read_chapter_view.dart';
import '../modules/readKomiku/bindings/read_komiku_binding.dart';
import '../modules/readKomiku/views/read_komiku_view.dart';

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
      page: () => KomikuHomeView(),
      binding: KomikuHomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MANGA_KOMIKU,
      page: () => const DetailMangaKomikuView(),
      binding: DetailMangaKomikuBinding(),
    ),
    GetPage(
      name: _Paths.READ_KOMIKU,
      page: () => const ReadKomikuView(),
      binding: ReadKomikuBinding(),
    ),
    GetPage(
      name: _Paths.GENRE_KOMIKU,
      page: () => const GenreKomikuView(),
      binding: GenreKomikuBinding(),
    ),
  ];
}

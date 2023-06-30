import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/komikstation/genre_komikstation.dart';

import '../modules/detailManga/bindings/detail_manga_binding.dart';
import '../modules/detailManga/views/detail_manga_view.dart';
import '../modules/detailMangaKomicast/bindings/detail_manga_komicast_binding.dart';
import '../modules/detailMangaKomicast/views/detail_manga_komicast_view.dart';
import '../modules/detailMangaKomiku/bindings/detail_manga_komiku_binding.dart';
import '../modules/detailMangaKomiku/views/detail_manga_komiku_view.dart';
import '../modules/genreKomicast/bindings/genre_komicast_binding.dart';
import '../modules/genreKomicast/views/genre_komicast_view.dart';
import '../modules/genreKomiku/bindings/genre_komiku_binding.dart';
import '../modules/genreKomiku/views/genre_komiku_view.dart';
import '../modules/genreKomikstation/bindings/genre_komikstation_binding.dart';
import '../modules/genreKomikstation/views/genre_komikstation_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/komicastHome/bindings/komicast_home_binding.dart';
import '../modules/komicastHome/views/komicast_home_view.dart';
import '../modules/komikuHome/bindings/komiku_home_binding.dart';
import '../modules/komikuHome/views/komiku_home_view.dart';
import '../modules/readChapter/bindings/read_chapter_binding.dart';
import '../modules/readChapter/views/read_chapter_view.dart';
import '../modules/readKomicast/bindings/read_komicast_binding.dart';
import '../modules/readKomicast/views/read_komicast_view.dart';
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
    GetPage(
      name: _Paths.GENRE_MANHWAINDO,
      page: () => const GenreKomikstationView(),
      binding: GenreManhwaindoBinding(),
    ),
    GetPage(
      name: _Paths.KOMICAST_HOME,
      page: () => const KomicastHomeView(),
      binding: KomicastHomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MANGA_KOMICAST,
      page: () => const DetailMangaKomicastView(),
      binding: DetailMangaKomicastBinding(),
    ),
    GetPage(
      name: _Paths.READ_KOMICAST,
      page: () => const ReadKomicastView(),
      binding: ReadKomicastBinding(),
    ),
    GetPage(
      name: _Paths.GENRE_KOMICAST,
      page: () => const GenreKomicastView(),
      binding: GenreKomicastBinding(),
    ),
  ];
}

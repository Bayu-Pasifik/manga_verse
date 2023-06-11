import 'package:get/get.dart';

import '../controllers/detail_manga_komiku_controller.dart';

class DetailMangaKomikuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMangaKomikuController>(
      () => DetailMangaKomikuController(),
    );
  }
}

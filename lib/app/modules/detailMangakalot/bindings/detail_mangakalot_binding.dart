import 'package:get/get.dart';

import '../controllers/detail_mangakalot_controller.dart';

class DetailMangakalotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMangakalotController>(
      () => DetailMangakalotController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/detail_manga_komicast_controller.dart';

class DetailMangaKomicastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMangaKomicastController>(
      () => DetailMangaKomicastController(),
    );
  }
}

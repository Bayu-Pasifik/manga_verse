import 'package:get/get.dart';

import '../controllers/genre_mangakalot_controller.dart';

class GenreMangakalotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreMangakalotController>(
      () => GenreMangakalotController(),
    );
  }
}

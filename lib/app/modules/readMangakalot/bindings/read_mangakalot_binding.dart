import 'package:get/get.dart';

import '../controllers/read_mangakalot_controller.dart';

class ReadMangakalotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadMangakalotController>(
      () => ReadMangakalotController(),
    );
  }
}

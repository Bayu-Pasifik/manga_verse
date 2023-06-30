import 'package:get/get.dart';

import '../controllers/mangakalot_home_controller.dart';

class MangakalotHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MangakalotHomeController>(
      () => MangakalotHomeController(),
    );
  }
}

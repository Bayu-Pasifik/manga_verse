import 'package:get/get.dart';

import '../controllers/detail_mangageko_controller.dart';

class DetailMangagekoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMangagekoController>(
      () => DetailMangagekoController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/genre_mangageko_controller.dart';

class GenreMangagekoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreMangagekoController>(
      () => GenreMangagekoController(),
    );
  }
}

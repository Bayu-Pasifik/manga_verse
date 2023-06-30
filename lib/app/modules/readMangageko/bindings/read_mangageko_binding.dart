import 'package:get/get.dart';

import '../controllers/read_mangageko_controller.dart';

class ReadMangagekoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadMangagekoController>(
      () => ReadMangagekoController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/read_chapter_controller.dart';

class ReadChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadChapterController>(
      () => ReadChapterController(),
    );
  }
}

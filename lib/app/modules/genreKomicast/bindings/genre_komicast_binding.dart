import 'package:get/get.dart';

import '../controllers/genre_komicast_controller.dart';

class GenreKomicastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreKomicastController>(
      () => GenreKomicastController(),
    );
  }
}

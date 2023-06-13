import 'package:get/get.dart';

import '../controllers/genre_komiku_controller.dart';

class GenreKomikuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreKomikuController>(
      () => GenreKomikuController(),
    );
  }
}

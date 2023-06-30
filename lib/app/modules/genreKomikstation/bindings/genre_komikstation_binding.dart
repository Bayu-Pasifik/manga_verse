import 'package:get/get.dart';

import '../controllers/genre_komikstation_controller.dart';

class GenreManhwaindoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreKomikstationController>(
      () => GenreKomikstationController(),
    );
  }
}

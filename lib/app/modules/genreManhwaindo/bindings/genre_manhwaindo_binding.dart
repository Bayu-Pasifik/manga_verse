import 'package:get/get.dart';

import '../controllers/genre_manhwaindo_controller.dart';

class GenreManhwaindoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreManhwaindoController>(
      () => GenreManhwaindoController(),
    );
  }
}

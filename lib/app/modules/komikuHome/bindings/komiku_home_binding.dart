import 'package:get/get.dart';

import '../controllers/komiku_home_controller.dart';

class KomikuHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomikuHomeController>(
      () => KomikuHomeController(),
    );
  }
}

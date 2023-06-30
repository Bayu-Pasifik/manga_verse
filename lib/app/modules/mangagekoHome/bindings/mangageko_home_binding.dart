import 'package:get/get.dart';

import '../controllers/mangageko_home_controller.dart';

class MangagekoHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MangagekoHomeController>(
      () => MangagekoHomeController(),
    );
  }
}

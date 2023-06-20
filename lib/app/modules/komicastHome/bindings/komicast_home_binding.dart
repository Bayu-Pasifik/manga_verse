import 'package:get/get.dart';

import '../controllers/komicast_home_controller.dart';

class KomicastHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomicastHomeController>(
      () => KomicastHomeController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/read_komicast_controller.dart';

class ReadKomicastBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadKomicastController>(
      () => ReadKomicastController(),
    );
  }
}

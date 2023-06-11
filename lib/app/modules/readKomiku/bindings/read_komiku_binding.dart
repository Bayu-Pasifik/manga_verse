import 'package:get/get.dart';

import '../controllers/read_komiku_controller.dart';

class ReadKomikuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadKomikuController>(
      () => ReadKomikuController(),
    );
  }
}

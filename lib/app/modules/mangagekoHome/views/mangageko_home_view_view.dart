import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_verse/app/modules/mangagekoHome/controllers/mangageko_home_controller.dart';

class MangagekoHomePageView extends GetView<MangagekoHomeController> {
  const MangagekoHomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MangagekoHomeViewView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MangagekoHomeViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

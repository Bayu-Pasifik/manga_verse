import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mangakalot_home_controller.dart';

class MangakalotHomeView extends GetView<MangakalotHomeController> {
  const MangakalotHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MangakalotHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MangakalotHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

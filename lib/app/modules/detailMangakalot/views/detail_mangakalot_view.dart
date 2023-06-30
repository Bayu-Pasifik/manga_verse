import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_mangakalot_controller.dart';

class DetailMangakalotView extends GetView<DetailMangakalotController> {
  const DetailMangakalotView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailMangakalotView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailMangakalotView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

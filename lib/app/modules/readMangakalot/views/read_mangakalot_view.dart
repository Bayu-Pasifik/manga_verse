import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/read_mangakalot_controller.dart';

class ReadMangakalotView extends GetView<ReadMangakalotController> {
  const ReadMangakalotView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadMangakalotView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReadMangakalotView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

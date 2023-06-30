import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MangakalotGenrePageView extends GetView {
  const MangakalotGenrePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MangakalotGenrePageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MangakalotGenrePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

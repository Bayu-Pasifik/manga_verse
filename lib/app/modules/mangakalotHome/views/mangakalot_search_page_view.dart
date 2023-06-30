import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MangakalotSearchPageView extends GetView {
  const MangakalotSearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MangakalotSearchPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MangakalotSearchPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

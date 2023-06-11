import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KomikuSearchPageView extends GetView {
  const KomikuSearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KomikuSearchPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KomikuSearchPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

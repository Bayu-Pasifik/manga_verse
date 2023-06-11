import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KomikuGenrePageView extends GetView {
  const KomikuGenrePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KomikuGenrePageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KomikuGenrePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

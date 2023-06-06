import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GenreView extends GetView {
  const GenreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenreView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_verse/app/modules/home/views/genre_view.dart';
import 'package:manga_verse/app/modules/home/views/homepage_view.dart';
import 'package:manga_verse/app/modules/home/views/search_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Container(
          child: Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: const [HomepageView(), GenreView(), SearchView()],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap: (i) {
              print(controller.currentIndex.value);
              controller.currentIndex.value = i;
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: const Icon(Icons.movie),
                title: const Text("Genre"),
                selectedColor: Colors.pink,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Search"),
                selectedColor: Colors.orange,
              ),
            ],
          ),
        ));
  }
}

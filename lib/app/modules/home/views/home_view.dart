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
        backgroundColor: Colors.white,
        body: Container(
          child: Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: [HomepageView(), GenreView(), const SearchView()],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap: (i) {
              if (i <= 2) {
                controller.searchController.clear();
                controller.clearSearch();
              }
              controller.currentIndex.value = i;
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: const Color(0XFF54BAB9),
              ),

              /// Genre
              SalomonBottomBarItem(
                icon: Container(
                    width: 40,
                    height: 30,
                    child: Image.asset("assets/images/genre.png")),
                title: const Text("Genre"),
                selectedColor: const Color(0XFF54BAB9),
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Search"),
                selectedColor: const Color(0XFF54BAB9),
              ),
            ],
          ),
        ));
  }
}

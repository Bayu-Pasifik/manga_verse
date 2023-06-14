import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_verse/app/modules/komikuHome/views/komiku_genre_page_view.dart';
import 'package:manga_verse/app/modules/komikuHome/views/komiku_home_page_view.dart';
import 'package:manga_verse/app/modules/komikuHome/views/komiku_search_page_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../controllers/komiku_home_controller.dart';

class KomikuHomeView extends GetView<KomikuHomeController> {
  const KomikuHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Obx(
            () => IndexedStack(
              index: controller.currentIndex.value,
              children: [
                KomikuHomePageView(),
                KomikuGenrePageView(),
                KomikuSearchPageView()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap: (i) {
              if (i < 3) {
                controller.allSearch.clear();
                controller.searchController.clear();
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

              /// Likes
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

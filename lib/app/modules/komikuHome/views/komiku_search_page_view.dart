import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
import 'package:manga_verse/app/modules/komikuHome/controllers/komiku_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KomikuSearchPageView extends GetView<KomikuHomeController> {
  final GlobalKey<ScaffoldState> searchkomikuState = GlobalKey<ScaffoldState>();
  KomikuSearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer? searchTimer;
    return Scaffold(
        key: searchkomikuState,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<KomikuHomeController>(
                builder: (c) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.black, size: 30),
                          onPressed: () {
                            print(searchkomikuState.currentState);
                            searchkomikuState.currentState?.openDrawer();
                          },
                        ),
                        SizedBox(
                          width: 250.0,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  '"${controller.greeting()} , Pembaca",',
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TypewriterAnimatedText("Mau cari apa hari ini ?",
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: c.searchController,
                      onChanged: (value) {
                        searchTimer?.cancel();

                        if (value.isEmpty) {
                          // Jika nilai di TextField kosong, hapus hasil pencarian dan perbarui UI
                          controller.clearSearch();
                          controller.update(); // Perbarui UI menggunakan GetX
                        } else if (value.length <= 2) {
                          controller.clearSearch();
                          controller.update();
                        } else {
                          // Mulai timer baru dengan delay 1 detik
                          searchTimer =
                              Timer(const Duration(milliseconds: 300), () {
                            controller.clearSearch();
                            controller.getSearch(value);
                            print(value);
                            controller.update(); // Perbarui UI menggunakan GetX
                          });
                        }
                      },
                      maxLength: 20,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.search)),
                    ),
                    Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            // color: Colors.amber,
                            child: (c.searchController.text != "" ||
                                    c.searchController.text.length >= 2)
                                ?
                                // ! all manga
                                SmartRefresher(
                                    controller: c.searchRefresh,
                                    enablePullDown: true,
                                    enablePullUp: true,
                                    onRefresh: () => c
                                        .refreshSearch(c.searchController.text),
                                    onLoading: () =>
                                        c.loadSearch(c.searchController.text),
                                    child: (c.allSearch.isEmpty)
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 10),
                                            itemBuilder: (context, index) {
                                              KomikuAll manga =
                                                  c.allSearch[index];
                                              return Material(
                                                elevation: 2,
                                                color: const Color(0XFFFFFFFF),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: ListTile(
                                                  onTap: () => Get.toNamed(
                                                      Routes.DETAIL_MANGA,
                                                      arguments:
                                                          manga.endpoint),
                                                  leading: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                      maxHeight: 200,
                                                    ),
                                                    child: Container(
                                                      width: 50,
                                                      // color: Colors.red,
                                                      child: CachedNetworkImage(
                                                        imageUrl: manga.thumb!
                                                                .startsWith(
                                                                    "https:///")
                                                            ? manga.thumb!
                                                                .replaceFirst(
                                                                    "https:///",
                                                                    "https://")
                                                            : manga.thumb!,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/images/no-image.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  title: SizedBox(
                                                      width: context.width,
                                                      height: 20,
                                                      child: Text(
                                                          "${manga.title}",
                                                          style: GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              textStyle:
                                                                  const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis)))),
                                                  subtitle: Text(
                                                    "${manga.updatedOn}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: const Color(
                                                            0XFFFF6905)),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                controller.allSearch.length,
                                          ),
                                  )
                                : const Center(
                                    child: Text("Kamu belum mencari apapun"))))
                  ],
                ),
              )),
        ));
  }
}

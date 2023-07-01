import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manga_verse/app/data/models/komiku/komiku_all_model.dart';
import 'package:manga_verse/app/modules/komikuHome/controllers/komiku_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class KomikuSearchPageView extends GetView<KomikuHomeController> {
  const KomikuSearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 10),
            TextField(
              controller: controller.searchController,
              focusNode: FocusNode(canRequestFocus: false),
              autofocus: false,
              maxLength: 20,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  controller.clearSearch();
                  controller.setIsSearching(true);
                  Future.delayed(const Duration(seconds: 3), () {
                    controller.searchMangaAPI(controller.searchController.text,
                        controller.searchMangaController.firstPageKey);
                    controller.setIsSearching(false);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF54BAB9),
                ),
                child: Text("Cari", style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ),
            Obx(() => (controller.isSearch.isFalse)
                ? Expanded(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child:
                            // ! all manga
                            PagedListView<int, KomikuAll>.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          pagingController: controller.searchMangaController,
                          builderDelegate: PagedChildBuilderDelegate<KomikuAll>(
                            animateTransitions: true,
                            itemBuilder: (context, item, index) => Material(
                                elevation: 2,
                                color: const Color(0XFFFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  onTap: () => Get.toNamed(
                                      Routes.DETAIL_MANGA_KOMIKU,
                                      arguments: item.endpoint),
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                    ),
                                    child: SizedBox(
                                      width: 50,
                                      child: CachedNetworkImage(
                                        imageUrl: item.thumb ?? "",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
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
                                      child: Text("${item.title}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              textStyle: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis)))),
                                  subtitle: Text(
                                    "${item.updatedOn}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0XFFFF6905)),
                                  ),
                                )),
                            firstPageErrorIndicatorBuilder: (_) {
                              return DelayedDisplay(
                                delay: const Duration(seconds: 2),
                                child: Center(
                                    child: Text(
                                        "Kamu belum mencari manga apapun \nCari sekarang",
                                        style: GoogleFonts.poppins())),
                              );
                            },
                            newPageErrorIndicatorBuilder: (context) =>
                                Text("${controller.allmangaController.error}"),
                            firstPageProgressIndicatorBuilder: (context) =>
                                Center(
                              child: LoadingAnimationWidget.hexagonDots(
                                  color: const Color(0XFF54BAB9), size: 50),
                            ),
                            newPageProgressIndicatorBuilder: (context) =>
                                Center(
                              child: LoadingAnimationWidget.hexagonDots(
                                  color: const Color(0XFF54BAB9), size: 50),
                            ),
                            noItemsFoundIndicatorBuilder: (_) {
                              return const DelayedDisplay(
                                  delay: Duration(seconds: 1),
                                  child: Center(
                                    child: Text('No data found'),
                                  ));
                            },
                            noMoreItemsIndicatorBuilder: (_) {
                              return const Center(
                                child: Text('No More Data'),
                              );
                            },
                          ),
                        )))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Please wait",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        const SizedBox(height: 10),
                        LoadingAnimationWidget.hexagonDots(
                            color: const Color(0XFF54BAB9), size: 50),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    ));
  }
}

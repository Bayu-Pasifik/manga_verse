import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manga_verse/app/data/models/komikstation/komikstation_all.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchView extends GetView<HomeController> {
  const SearchView({Key? key}) : super(key: key);
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
                  controller.searchMangaAPI(controller.searchController.text,
                      controller.searchMangaController.firstPageKey);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF54BAB9),
                ),
                child: Text("Cari", style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ),
            Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    // color: Colors.amber,
                    child:
                        // ! all manga
                        PagedListView<int, KomikstationAll>.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      pagingController: controller.searchMangaController,
                      builderDelegate:
                          PagedChildBuilderDelegate<KomikstationAll>(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) => Material(
                            elevation: 2,
                            color: const Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(10),
                            child: ListTile(
                              onTap: () => Get.toNamed(Routes.DETAIL_MANGA,
                                  arguments: item.endpoint),
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 200,
                                ),
                                child: Container(
                                  width: 50,
                                  // color: Colors.red,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        item.thumbnail!.startsWith("https:///")
                                            ? item.thumbnail!.replaceFirst(
                                                "https:///", "https://")
                                            : item.thumbnail!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
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
                                "${item.latestChapter}",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0XFFFF6905)),
                              ),
                            )),
                        firstPageErrorIndicatorBuilder: (_) {
                          return Center(
                              child: Text(
                                  "Kamu belum mencari manga apapun \nCari sekarang",
                                  style: GoogleFonts.poppins()));
                        },
                        newPageErrorIndicatorBuilder: (context) =>
                            Text("${controller.allmangaController.error}"),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        newPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        noItemsFoundIndicatorBuilder: (_) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        },
                        noMoreItemsIndicatorBuilder: (_) {
                          return const Center(
                            child: Text('No data found'),
                          );
                        },
                      ),
                    )))
          ],
        ),
      ),
    ));
  }
}

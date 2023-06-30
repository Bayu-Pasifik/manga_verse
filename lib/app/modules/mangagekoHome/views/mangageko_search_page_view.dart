import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manga_verse/app/data/models/mangageko/mangageko_all.dart';
import 'package:manga_verse/app/modules/mangagekoHome/controllers/mangageko_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class MangagekoSearchPageView extends GetView<MangagekoHomeController> {
  const MangagekoSearchPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<MangagekoHomeController>(
            builder: (c) {
              return Column(
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
                    controller: c.searchController,
                    focusNode: FocusNode(canRequestFocus: false),
                    autofocus: false,
                    maxLength: 20,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)),
                  ),
                  const SizedBox(height: 1),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        c.clearSearch();
                        c.setIsSearching(true);
                        Future.delayed(const Duration(seconds: 2), () {
                          c
                              .searchmanga(controller.searchController.text)
                              .then((_) {
                            c.setIsSearching(false);
                            c.setSearchResultsLoaded(true);
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF54BAB9),
                      ),
                      child: Text("Cari",
                          style: GoogleFonts.poppins(fontSize: 14)),
                    ),
                  ),
                  Obx(() => (c.isSearch.isFalse)
                      ? (c.isSearchResultsLoaded.isTrue)
                          ? Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, index) {
                                      MangagekoAll manga = c.listSearch[index];
                                      return Material(
                                        elevation: 2,
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                        child: ListTile(
                                          onTap: () => Get.toNamed(
                                              Routes.DETAIL_MANGA_KOMIKU,
                                              arguments: manga.endpoint),
                                          leading: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight: 200,
                                            ),
                                            child: SizedBox(
                                              width: 50,
                                              // color: Colors.red,
                                              child: CachedNetworkImage(
                                                imageUrl: manga.imageUrl!
                                                        .startsWith("https:///")
                                                    ? manga.imageUrl!
                                                        .replaceFirst(
                                                            "https:///",
                                                            "https://")
                                                    : manga.imageUrl!,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
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
                                              child: Text("${manga.title}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      textStyle: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis)))),
                                          subtitle: Text(
                                            "${manga.latestChapter}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: const Color(0XFFFF6905)),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.listSearch.length,
                                  )))
                          : Center(
                              child: Text("Kamu belum mencari manga",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            )
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
                        ))
                ],
              );
            },
          )),
    ));
  }
}

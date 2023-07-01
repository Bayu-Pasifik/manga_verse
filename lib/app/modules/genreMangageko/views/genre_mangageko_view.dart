import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/mangageko/mangageko_all.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/genre_mangageko_controller.dart';

class GenreMangagekoView extends GetView<GenreMangagekoController> {
  const GenreMangagekoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String genre = Get.arguments;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.gridMode();
            },
            child: Obx(
              () => (controller.isGrid.isFalse)
                  ? const Icon(Icons.grid_on)
                  : const Icon(Icons.list),
            )),
        backgroundColor: const Color(0XFFF4F3FD),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black, size: 30),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        SizedBox(
                          width: 250.0,
                          child: AnimatedTextKit(
                            repeatForever: true,
                            pause: const Duration(milliseconds: 1000),
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  '"${controller.greeting()} , Pembaca",',
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TypewriterAnimatedText("Mau baca apa hari ini?",
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GetBuilder<GenreMangagekoController>(
                        builder: (c) {
                          return SmartRefresher(
                              controller: c.allRefresh,
                              enablePullDown: true,
                              enablePullUp: true,
                              onRefresh: () => c.refreshData(genre),
                              onLoading: () => c.loadData(genre),
                              child: (c.allManga.isEmpty)
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : (controller.isGrid.isFalse)
                                      ? ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 10),
                                          itemBuilder: (context, index) {
                                            MangagekoAll manga =
                                                c.allManga[index];
                                            return Material(
                                              elevation: 2,
                                              color: const Color(0XFFFFFFFF),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: ListTile(
                                                onTap: () => Get.toNamed(
                                                    Routes.DETAIL_MANGAGEKO,
                                                    arguments: manga.endpoint),
                                                leading: ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxHeight: 200,
                                                  ),
                                                  child: SizedBox(
                                                    width: 50,
                                                    // color: Colors.red,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          manga.imageUrl ?? "",
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
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
                                                         const Center(child:  CircularProgressIndicator()),
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
                                                            textStyle: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis)))),
                                                subtitle: Text(
                                                  "${manga.latestChapter}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0XFFFF6905)),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: controller.allManga.length,
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  mainAxisExtent: 180,
                                                  mainAxisSpacing: 10),
                                          itemBuilder: (_, index) {
                                            MangagekoAll manga =
                                                controller.allManga[index];
                                            return GestureDetector(
                                              onTap: () => Get.toNamed(
                                                  Routes.DETAIL_MANGAGEKO,
                                                  arguments: manga.endpoint),
                                              child: Card(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      height: 150,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            manga.imageUrl ??
                                                                "",
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
                                                           const Center(child:  CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Image.asset(
                                                          "assets/images/no-image.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 20,
                                                      child: Text(
                                                          "${manga.title}",
                                                          maxLines: 1,
                                                          style: GoogleFonts.inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              textStyle:
                                                                  const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis))),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: controller.allManga.length,
                                        ));
                        },
                      ),
                    ),
                  ],
                ))));
  }
}

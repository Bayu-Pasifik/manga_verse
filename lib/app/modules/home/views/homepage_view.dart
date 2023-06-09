import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomepageView extends GetView<HomeController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF4F3FD),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${controller.greeting()} , Pembaca",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("Siap untuk menjelajahi dunia manga?",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text(
                  "Weekly Trending",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  width: context.width,
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  // color: Colors.amber,
                  child: FutureBuilder(
                    future: controller.popularManga(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      }
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          AllMangaModel trending = snapshot.data![index];
                          return GestureDetector(
                            onTap: () => Get.toNamed(Routes.DETAIL_MANGA,
                                arguments: trending.endpoint),
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: trending.thumbnail!.startsWith("https:///") ? trending.thumbnail!.replaceFirst("https:///", "https://") : trending.thumbnail!,
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
                                const SizedBox(height: 10),
                                Expanded(
                                  child: SizedBox(
                                      width: 80,
                                      height: 50,
                                      child: Text("${trending.title}",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              textStyle: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis)))),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TabBar(
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Semua",
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Baru",
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ),
                    ),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0XFF858597),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0XFF54BAB9),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: TabBarView(children: [
                    // ! all manga
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return SmartRefresher(
                          controller: c.allRefresh,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () => c.refreshData(c.hal.value),
                          onLoading: () => c.loadData(c.hal.value),
                          child: (c.allManga.isEmpty)
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    AllMangaModel manga = c.allManga[index];
                                    return Material(
                                      elevation: 2,
                                      color: const Color(0XFFFFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                      child: ListTile(
                                        onTap: () => Get.toNamed(
                                            Routes.DETAIL_MANGA,
                                            arguments: manga.endpoint),
                                        leading: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxHeight: 200,
                                          ),
                                          child: Container(
                                            width: 50,
                                            // color: Colors.red,
                                            child: CachedNetworkImage(
                                              imageUrl: manga.thumbnail!.startsWith("https:///") ? manga.thumbnail!.replaceFirst("https:///", "https://") : manga.thumbnail!,
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
                                  itemCount: controller.allManga.length,
                                ),
                        );
                      },
                    ),
                    // ! New Manga
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return SmartRefresher(
                          controller: c.latestRefresh,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () => c.refreshUpdate(c.hal.value),
                          onLoading: () => c.loadUpdate(c.hal.value),
                          child: (c.latest.isEmpty)
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    AllMangaModel manga = c.latest[index];
                                    return Material(
                                      elevation: 2,
                                      color: const Color(0XFFFFFFFF),
                                      borderRadius: BorderRadius.circular(10),
                                      child: ListTile(
                                        onTap: () => Get.toNamed(
                                            Routes.DETAIL_MANGA,
                                            arguments: manga.endpoint),
                                        leading: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxHeight: 200,
                                          ),
                                          child: Container(
                                            width: 50,
                                            // color: Colors.red,
                                            child: CachedNetworkImage(
                                              imageUrl: manga.thumbnail!.startsWith("https:///") ? manga.thumbnail!.replaceFirst("https:///", "https://") : manga.thumbnail!,
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
                                        subtitle: Text("${manga.latestChapter}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color:
                                                    const Color(0XFFFF6905))),
                                      ),
                                    );
                                  },
                                  itemCount: controller.allManga.length,
                                ),
                        );
                      },
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

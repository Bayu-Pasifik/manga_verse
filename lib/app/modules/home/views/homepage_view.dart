import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manga_verse/app/data/models/komikstation/komikstation_all.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomepageView extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0XFF54BAB9)),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Manga Verse',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 20))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    height: context.height / 2,
                    width: context.width,
                    child: ExpandablePanel(
                      header: Text(
                        "Manga Indo",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      collapsed: Text(
                        "================================",
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0XFF858597)),
                      ),
                      expanded: Column(
                        children: [
                          ListTile(
                            onTap: () => Get.toNamed(Routes.HOME),
                            leading: const Icon(Icons.home),
                            title: Text("KOMIK STATION",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                          const Divider(
                            // thickness: 2,
                            color: Colors.black,
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.KOMIKU_HOME),
                            leading: const Icon(Icons.home),
                            title: Text("KOMIKU",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                          const Divider(
                            // thickness: 2,
                            color: Colors.black,
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.KOMICAST_HOME),
                            leading: const Icon(Icons.home),
                            title: Text("KOMIKCAST",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height / 2,
                    width: context.width,
                    child: ExpandablePanel(
                      header: Text(
                        "Manga Eng",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      collapsed: Text(
                        "================================",
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0XFF858597)),
                      ),
                      expanded: Column(
                        children: [
                          ListTile(
                            onTap: () => Get.toNamed(Routes.MANGAGEKO_HOME),
                            leading: const Icon(Icons.home),
                            title: Text("MANGAGEKO",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                          const Divider(
                            // thickness: 2,
                            color: Colors.black,
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.MANGAKALOT_HOME),
                            leading: const Icon(Icons.home),
                            title: Text("MANGAKALOT",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                          const Divider(
                            // thickness: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0XFFF4F3FD),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.menu, color: Colors.black, size: 30),
                      onPressed: () {
                        scaffoldState.currentState?.openDrawer();
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
                const SizedBox(height: 15),
                Text(
                  "Weekly Trending",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Container(
                  width: context.width,
                  height: 150,
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
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          KomikstationAll trending = snapshot.data![index];
                          return GestureDetector(
                            onTap: () => Get.toNamed(Routes.DETAIL_MANGA,
                                arguments: trending.endpoint),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    imageUrl: trending.thumbnail!
                                            .startsWith("https:///")
                                        ? trending.thumbnail!.replaceFirst(
                                            "https:///", "https://")
                                        : trending.thumbnail!,
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
                                      const  Center(child:  CircularProgressIndicator()),
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
                const SizedBox(height: 5),
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
                        child: Text("Tamat",
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
                    PagedListView<int, KomikstationAll>.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      pagingController: controller.allmangaController,
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
                                child: SizedBox(
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ada Masalah Nih",
                                style: GoogleFonts.inter(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF54BAB9)),
                                  onPressed: () => controller.allmangaController
                                      .retryLastFailedRequest(),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.restart_alt),
                                      Text("Retry"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                        },
                        newPageErrorIndicatorBuilder: (context) =>
                           Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ada Masalah Nih",
                                style: GoogleFonts.inter(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF54BAB9)),
                                  onPressed: () => controller.allmangaController
                                      .retryLastFailedRequest(),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.restart_alt),
                                      Text("Retry"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.hexagonDots(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        transitionDuration: const Duration(seconds: 3),
                        newPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.hexagonDots(
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
                    ),
                    // ! completed Manga
                    PagedListView<int, KomikstationAll>.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      pagingController: controller.allLatestManga,
                      builderDelegate:
                          PagedChildBuilderDelegate<KomikstationAll>(
                        animateTransitions: true,
                        // noItemsFoundIndicatorBuilder: (context) =>
                        //     Fluttertoast.showToast(msg: "TEST"),
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
                                child: SizedBox(
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
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ada Masalah Nih",
                                style: GoogleFonts.inter(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF54BAB9)),
                                  onPressed: () => controller.allLatestManga
                                      .retryLastFailedRequest(),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.restart_alt),
                                      Text("Retry"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                        },
                        newPageErrorIndicatorBuilder: (context) =>
                            Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ada Masalah Nih",
                                style: GoogleFonts.inter(fontSize: 18),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF54BAB9)),
                                  onPressed: () => controller.allLatestManga
                                      .retryLastFailedRequest(),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.restart_alt),
                                      Text("Retry"),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.hexagonDots(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        transitionDuration: const Duration(seconds: 3),
                        newPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.hexagonDots(
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

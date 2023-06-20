import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:manga_verse/app/data/models/all_manga_model.dart';
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
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Manhwa Indo'),
              onTap: () {
                Get.offNamed(Routes.HOME);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Komiku indo'),
              onTap: () {
                Get.offNamed(Routes.KOMIKU_HOME);
              },
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
                      icon: Icon(Icons.menu, color: Colors.black, size: 30),
                      onPressed: () {
                        print(scaffoldState.currentState);
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
                    PagedListView<int, AllMangaModel>.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      pagingController: controller.allmangaController,
                      builderDelegate: PagedChildBuilderDelegate<AllMangaModel>(
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
                                  "${controller.allmangaController.error}"));
                        },
                        newPageErrorIndicatorBuilder: (context) =>
                            Text("${controller.allmangaController.error}"),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        transitionDuration: const Duration(seconds: 3),
                        newPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        noItemsFoundIndicatorBuilder: (_) {
                          Get.snackbar("Error", "No Data Found");
                          return const Center(
                            child: Text('No data found'),
                          );
                        },
                        noMoreItemsIndicatorBuilder: (_) {
                          Get.snackbar("Error", "No more Data");

                          return const Center(
                            child: Text('No data found'),
                          );
                        },
                      ),
                    ),
                    // ! New Manga
                    PagedListView<int, AllMangaModel>.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      pagingController: controller.allLatestManga,
                      builderDelegate: PagedChildBuilderDelegate<AllMangaModel>(
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
                              child:
                                  Text("${controller.allLatestManga.error}"));
                        },
                        newPageErrorIndicatorBuilder: (context) =>
                            Text("${controller.allLatestManga.error}"),
                        firstPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        transitionDuration: const Duration(seconds: 3),
                        newPageProgressIndicatorBuilder: (context) => Center(
                          child: LoadingAnimationWidget.inkDrop(
                              color: const Color(0XFF54BAB9), size: 50),
                        ),
                        noItemsFoundIndicatorBuilder: (_) {
                          Get.snackbar("Error", "No Data Found");
                          return const Center(
                            child: Text('No data found'),
                          );
                        },
                        noMoreItemsIndicatorBuilder: (_) {
                          Get.snackbar("Error", "No more Data");

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

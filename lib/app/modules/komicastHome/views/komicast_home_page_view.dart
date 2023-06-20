import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/komikcast/komikcast_all.dart';
import 'package:manga_verse/app/modules/komicastHome/controllers/komicast_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class KomicastHomePageView extends GetView<KomicastHomeController> {
  const KomicastHomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Komicast'),
                onTap: () {
                  Get.offNamed(Routes.KOMICAST_HOME);
                },
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0XFFF4F3FD),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.menu, color: Colors.black, size: 30),
                  //   onPressed: () {
                  //     print(scaffoldState.currentState);
                  //     scaffoldState.currentState?.openDrawer();
                  //   },
                  // ),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Center(child: Text("Please Wait")),
                            const Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        KomikcastAll trending = snapshot.data![index];
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
                                  imageUrl: trending.imageUrl!
                                          .startsWith("https:///")
                                      ? trending.imageUrl!
                                          .replaceFirst("https:///", "https://")
                                      : trending.imageUrl!,
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
            ]),
          ),
        ));
  }
}

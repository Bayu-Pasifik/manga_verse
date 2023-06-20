import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/komikcast/genre_komicast.dart';
import 'package:manga_verse/app/modules/komicastHome/controllers/komicast_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class KomicastGenrePageView extends GetView<KomicastHomeController> {
  KomicastGenrePageView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> komicastGenreState =
      GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: komicastGenreState,
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
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu,
                                color: Colors.black, size: 30),
                            onPressed: () {
                              komicastGenreState.currentState?.openDrawer();
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
                                TypewriterAnimatedText(
                                    "Cari Genre Kesukaan mu disini",
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
                        child: FutureBuilder(
                          future: controller.listGenre(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please Wait",
                                      style: GoogleFonts.poppins(
                                          color: const Color(0XFFB8B8D2),
                                          fontSize: 24),
                                    ),
                                    const CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("${snapshot.error}"),
                              );
                            }
                            if (snapshot.hasData) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Please Wait",
                                      style: GoogleFonts.poppins(
                                          color: const Color(0XFFB8B8D2),
                                          fontSize: 24),
                                    ),
                                    const CircularProgressIndicator(),
                                  ],
                                );
                              }
                            }

                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                GenreKomicast genre = snapshot.data![index];
                                return Material(
                                  elevation: 2,
                                  color: const Color(0XFFFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                  child: ListTile(
                                    onTap: () => Get.toNamed(
                                        Routes.GENRE_KOMICAST,
                                        arguments: genre.endpoint),
                                    title: Text("${genre.genre}"),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ]))));
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/mangageko/mangageko_genre.dart';
import 'package:manga_verse/app/modules/mangagekoHome/controllers/mangageko_home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class MangagekoGenrePageView extends GetView<MangagekoHomeController> {
  const MangagekoGenrePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFF4F3FD),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                MangagekoGenre genre = snapshot.data![index];
                                return Material(
                                  elevation: 2,
                                  color: const Color(0XFFFFFFFF),
                                  borderRadius: BorderRadius.circular(10),
                                  child: ListTile(
                                    onTap: () => Get.toNamed(
                                        Routes.GENRE_MANGAGEKO,
                                        arguments: genre.endpoint),
                                    title: Text("${genre.genreName}"),
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

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/genre_model.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

class GenreView extends GetView<HomeController> {
  const GenreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XFFF4F3FD),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    TypewriterAnimatedText("Cari Genre Kesukaan mu disini",
                        textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  width: context.width,
                  height: context.height,
                  // color: Colors.amber,
                  child: FutureBuilder(
                    future: controller.listGenre(),
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
                              const SizedBox(height: 20),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            GenreModel genre = snapshot.data?[index];
                            return Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: ListTile(
                                onTap: () => Get.toNamed(
                                    Routes.GENRE_MANHWAINDO,
                                    arguments: genre.endpoint),
                                title: Text(
                                  "${genre.name}",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

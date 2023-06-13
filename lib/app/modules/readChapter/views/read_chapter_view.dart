import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/read_model.dart' as read;

import '../controllers/read_chapter_controller.dart';

class ReadChapterView extends GetView<ReadChapterController> {
  const ReadChapterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String url = Get.arguments;
    return Scaffold(
      body: FutureBuilder(
        future: controller.getChapter(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please Wait",
                    style: GoogleFonts.poppins(
                      color: const Color(0XFFB8B8D2),
                      fontSize: 24,
                    ),
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
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: controller.allchapter.length,
            itemBuilder: (context, index) {
              read.ReadModel chapter = controller.allchapter[index];
              return CachedNetworkImage(
                imageUrl: chapter.url!.startsWith("https:///")
                    ? chapter.url!.replaceFirst("https:///", "https://")
                    : chapter.url!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please Wait",
                      style: GoogleFonts.poppins(
                        color: const Color(0XFFB8B8D2),
                        fontSize: 24,
                      ),
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/no-image.png",
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

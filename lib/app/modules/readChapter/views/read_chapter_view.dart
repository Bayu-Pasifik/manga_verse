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
        if (snapshot.data == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please Wait",
                style: GoogleFonts.poppins(
                    color: const Color(0XFFB8B8D2), fontSize: 24),
              ),
              const CircularProgressIndicator(),
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please Wait",
                  style: GoogleFonts.poppins(
                      color: const Color(0XFFB8B8D2), fontSize: 24),
                ),
                const CircularProgressIndicator(),
              ],
            );
          }
        }

        return SizedBox(
          width: context.width,
          height: context.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              read.ReadModel chapter = snapshot.data![index];
              return Container(
                // width: 500,
                height: MediaQuery.of(context).size.height,
                child: CachedNetworkImage(
                  imageUrl: "${chapter.url}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Please Wait",
                        style: GoogleFonts.poppins(
                            color: const Color(0XFFB8B8D2), fontSize: 24),
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/no-image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          ),
        );
      },
    ));
  }
}

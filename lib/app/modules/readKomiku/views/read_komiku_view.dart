import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/komiku/read_komiku.dart';

import '../controllers/read_komiku_controller.dart';

class ReadKomikuView extends GetView<ReadKomikuController> {
  const ReadKomikuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String url = Get.arguments;
    print(url);
    return Scaffold(
        body: FutureBuilder(
      future: controller.getChapter(url),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Wait",
                  style: GoogleFonts.poppins(
                      color: const Color(0XFFB8B8D2), fontSize: 24),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          width: context.width / 1,
          height: context.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              ReadKomiku chapter = snapshot.data![index];
              return Container(
                // width: 500,
                height: MediaQuery.of(context).size.height,
                child: CachedNetworkImage(
                  imageUrl: (chapter.chapterImageLink!.isNotEmpty)
                      ? chapter.chapterImageLink!
                      : "",
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
            itemCount: controller.allchapter.length,
          ),
        );
      },
    ));
  }
}

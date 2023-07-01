import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/mangakalot/mangakalot_detail.dart';
import 'package:manga_verse/app/routes/app_pages.dart';

import '../controllers/detail_mangakalot_controller.dart';

class DetailMangakalotView extends GetView<DetailMangakalotController> {
  const DetailMangakalotView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String manga = Get.arguments;
    return Scaffold(
      backgroundColor: const Color(0XFFF4F3FD),
      body: SafeArea(
        child: FutureBuilder<MangakalotDetail>(
          future: controller.getDetail(manga),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
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
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("No Data Available"),
              );
            }

            final MangakalotDetail detail = snapshot.data!;

            return CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                leading: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0XFFF4F3FD),
                    borderRadius: BorderRadius.circular(180),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                ),
                snap: true,
                floating: true,
                pinned: true,
                expandedHeight: 250.0,
                backgroundColor: const Color(0XFF61BFAD),
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: detail.cover ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Column(
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
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/no-image.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 500,
                                    child: Text(
                                      "${detail.title}",
                                      softWrap: true,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        textStyle: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "${detail.views} Views",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0XFF858597),
                                        ),
                                      ),
                                      Text(
                                        " | ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0XFF858597),
                                        ),
                                      ),
                                      Text(
                                        " ${detail.chapters?.length ?? 0} Total Chapters",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: const Color(0XFF858597),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Wrap(
                          children: [
                            if (detail.genres != null)
                              for (var genres in detail.genres!)
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Chip(
                                    label: Text(genres),
                                    backgroundColor: const Color(0XFF61BFAD),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                    labelPadding: const EdgeInsets.all(5),
                                  ),
                                ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        ExpandablePanel(
                          header: Text(
                            "Tentang manga ini",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          collapsed: Text(
                            "${detail.synopsis}",
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0XFF858597),
                            ),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Synopsis",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(0XFF858597),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${detail.synopsis}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0XFF858597),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Informasi Tambahan",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(0XFF858597),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Table(
                                border: TableBorder.all(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  color: Colors.black12,
                                ),
                                children: [
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Alternatif Title",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (detail.alternativeTitle != "")
                                              ? "${detail.alternativeTitle}"
                                              : "${detail.title}",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Author",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (var author in detail.authors!)
                                              Text(
                                                author,
                                                style: GoogleFonts.poppins(),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Status",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${detail.status}",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Last Updated",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${detail.lastUpdates}",
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Total Chapter",
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${detail.chapters?.length}",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Mulai Baca",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final chapter = detail.chapters![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(
                                  Routes.READ_MANGAKALOT,
                                  arguments: chapter.chapterEndpoint,
                                );
                              },
                              leading: (index + 1 < 10)
                                  ? Text(
                                      "0${index + 1}",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFFB8B8D2),
                                        fontSize: 24,
                                      ),
                                    )
                                  : Text(
                                      "${index + 1}",
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFFB8B8D2),
                                        fontSize: 24,
                                      ),
                                    ),
                              title: Text(
                                "${chapter.chapterTitle}",
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFF1F1F39),
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                "${chapter.chapterUpload}",
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFF1F1F39),
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0XFF61BFAD),
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                child: const Icon(
                                  Icons.menu_book,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          itemCount: detail.chapters?.length ?? 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ]);
          },
        ),
      ),
    );
  }
}

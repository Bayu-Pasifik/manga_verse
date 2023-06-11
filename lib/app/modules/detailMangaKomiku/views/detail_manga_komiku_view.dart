import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/data/models/komiku/detail_komiku.dart';
import 'package:manga_verse/app/routes/app_pages.dart';
import '../controllers/detail_manga_komiku_controller.dart';

class DetailMangaKomikuView extends GetView<DetailMangaKomikuController> {
  const DetailMangaKomikuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String manga = Get.arguments;
    return Scaffold(
        backgroundColor: const Color(0XFFF4F3FD),
        body: SafeArea(
          child: FutureBuilder<DetailKomiku>(
            future: controller.getDetail(manga),
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
              final DetailKomiku detail = snapshot.data!;
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: const Color(0XFFF4F3FD),
                          borderRadius: BorderRadius.circular(180)),
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
                      title: Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(180)),
                        child: Center(
                          child: Text(
                            '${detail.type}',
                            style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        ),
                      ),
                      background: CachedNetworkImage(
                        imageUrl: detail.thumb ?? "",
                        // imageUrl: "",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(8),
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
                    ),
                  ),

                  //3
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ! Row untuk title sub title dan rating
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                            width: 500,
                                            child: Text(
                                              (detail.title!.contains("Komik"))
                                                  ? "${detail.title}"
                                                      .replaceAll("Komik", "")
                                                  : "${detail.title}",
                                              softWrap: true,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  textStyle: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            )),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              "${detail.views} Views ",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0XFF858597)),
                                            ),
                                            Text(
                                              " | ",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0XFF858597)),
                                            ),
                                            Text(
                                              " ${detail.chapter?.length ?? 0} Chapters ",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0XFF858597)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Wrap(
                                children: [
                                  for (var genres in detail.genreList!)
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Chip(
                                        label: Text("${genres.genreName}"),
                                        backgroundColor:
                                            const Color(0XFF61BFAD),
                                        labelStyle: GoogleFonts.poppins(
                                            color: Colors.white),
                                        labelPadding: const EdgeInsets.all(5),
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(height: 15),
                              ExpandablePanel(
                                header: Text(
                                  "Tentang manga ini",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                collapsed: Text(
                                  "${detail.synopsis}",
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0XFF858597)),
                                ),
                                // ! column untuk informasi tambahan
                                expanded: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Synopsis",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: const Color(0XFF858597))),
                                    const SizedBox(height: 10),
                                    Text("${detail.synopsis}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: const Color(0XFF858597))),
                                    const SizedBox(height: 10),
                                    Text("Informasi Tambahan",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: const Color(0XFF858597))),
                                    const SizedBox(height: 10),
                                    Table(
                                      border: TableBorder.all(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.black12),
                                      children: [
                                        TableRow(children: [
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
                                              "${detail.title}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Author",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${detail.author}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
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
                                          )
                                        ]),
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Released",
                                              style: GoogleFonts.poppins(),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${detail.type}",
                                            ),
                                          )
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text("Mulai Baca",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20)),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final chapter = detail.chapter![index];
                                  return ListTile(
                                    onTap: () {
                                      var endpoint = (chapter.chapterEndpoint)!
                                              .contains("httpsadmin-komiku-org")
                                          ? chapter.chapterEndpoint?.replaceAll(
                                              "httpsadmin-komiku-org", "")
                                          : chapter.chapterEndpoint;
                                      Get.toNamed(Routes.READ_KOMIKU,
                                          arguments: endpoint);
                                      print(
                                          "Chapter endpoint sebelum : ${chapter.chapterEndpoint}");
                                      print(
                                          "Chapter endpoint sesudah : ${endpoint}");
                                    },
                                    leading: (index + 1 < 10)
                                        ? Text(
                                            "0${index + 1}",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0XFFB8B8D2),
                                                fontSize: 24),
                                          )
                                        : Text(
                                            "${index + 1}",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0XFFB8B8D2),
                                                fontSize: 24),
                                          ),
                                    title: Text(
                                      "${chapter.chapterTitle}",
                                      style: GoogleFonts.poppins(
                                          color: const Color(0XFF1F1F39),
                                          fontSize: 14),
                                    ),
                                    // subtitle: Text(
                                    //   "${chapter.date}",
                                    //   style: GoogleFonts.poppins(
                                    //       color: const Color(0XFF1F1F39),
                                    //       fontSize: 14),
                                    // ),
                                    // isThreeLine: true,
                                    trailing: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: const Color(0XFF61BFAD),
                                          borderRadius:
                                              BorderRadius.circular(180)),
                                      child: const Icon(
                                        Icons.menu_book,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: detail.chapter?.length ?? 0,
                                // itemCount: 1,
                              )
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}

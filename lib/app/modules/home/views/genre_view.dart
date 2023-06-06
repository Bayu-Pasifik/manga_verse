import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';

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
              Text("${controller.greeting()} , Pembaca",
                  style: GoogleFonts.poppins(fontSize: 14)),
              const SizedBox(height: 5),
              Text("Siap untuk menjelajahi dunia manga?",
                  style: GoogleFonts.poppins(fontSize: 14)),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
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
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) => Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: ListTile(
                            title: Text(
                              "${snapshot.data![index].name}",
                              style: GoogleFonts.poppins(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

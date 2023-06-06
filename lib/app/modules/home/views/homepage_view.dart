import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/trending_model.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';

class HomepageView extends GetView<HomeController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        TrendingModel trending = snapshot.data![index];
                        return Column(
                          children: [
                            Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                  "${trending.thumbnail}",
                                  fit: BoxFit.cover,
                                )),
                            Expanded(
                                child: SizedBox(
                                    width: 80,
                                    height: 50,
                                    child: Text(
                                      "${trending.title}",
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    )))
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

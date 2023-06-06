import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/data/models/trending_model.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomepageView extends GetView<HomeController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageView'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Weekly Trending"),
                const SizedBox(height: 10),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                child: CachedNetworkImage(
                                  imageUrl: "${trending.thumbnail}",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    "assets/images/no-image.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: SizedBox(
                                    width: 80,
                                    height: 50,
                                    child: Text(
                                      "${trending.title}",
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    )),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TabBar(
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Semua"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Baru"),
                      ),
                    ),
                  ],
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0XFF54BAB9),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    GetBuilder<HomeController>(
                      builder: (c) {
                        return SmartRefresher(
                          controller: c.allRefresh,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () => c.refreshData(c.hal.value),
                          onLoading: () => c.loadData(c.hal.value),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              AllMangaModel manga = c.allManga[index];
                              return ListTile(
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                  ),
                                  child: Container(
                                    width: 50,
                                    // color: Colors.red,
                                    child: CachedNetworkImage(
                                      imageUrl: "${manga.thumbnail}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/no-image.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Container(
                                    width: context.width,
                                    height: 20,
                                    child: Text(
                                      "${manga.title}",
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    )),
                                subtitle: Text("${manga.latestChapter}"),
                              );
                            },
                            itemCount: controller.allManga.length,
                          ),
                        );
                      },
                    ),
                    Text("Ini Baru"),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

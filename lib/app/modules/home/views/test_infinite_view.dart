import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:manga_verse/app/data/models/all_manga_model.dart';
import 'package:manga_verse/app/modules/home/controllers/home_controller.dart';

class TestInfiniteView extends GetView<HomeController> {
  const TestInfiniteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestInfiniteView'),
        centerTitle: true,
      ),
      body: PagedListView<int, AllMangaModel>(
        pagingController: controller.allmangaController,
        builderDelegate: PagedChildBuilderDelegate<AllMangaModel>(
          animateTransitions: true,
          noItemsFoundIndicatorBuilder: (context) => Container(
            width: 200,
            height: 200,
            child: Text("NO DATA"),
          ),
          itemBuilder: (context, item, index) => ListTile(
            title:
                Text("${item.title}"), // Menggunakan properti title dari item
          ),
          firstPageErrorIndicatorBuilder: (_) {
            // controller.allmangaController.refresh();
            return Center(
              child: Text("Loading"),
            );
          },
          firstPageProgressIndicatorBuilder: (context) => Center(
            child: Text("Loading nih bang"),
          ),
          transitionDuration: Duration(seconds: 3),
          newPageProgressIndicatorBuilder: (context) => Center(
            child: Text("Load data lain bang sabar bang"),
          ),
          
          noMoreItemsIndicatorBuilder: (context) {
            return Center(
              child: Text("No More Data"),
            );
          },
        ),
      ),
    );
  }
}

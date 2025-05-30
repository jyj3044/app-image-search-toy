import 'package:app_image_search_toy/ui/pages/main/component/search_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_view_model.dart';

class TabBarViewFavorite extends StatelessWidget {
  final MainViewModel controller;

  const TabBarViewFavorite({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              final data = controller.favoriteDataList;

              if (data.isEmpty) {
                return Center(
                  child: Text(
                    "Add your favorite image",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                );
              }

              return PageView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final url = data[index];
                  return SearchImage(
                    imageDocument: url,
                    controller: controller,
                  );
                },
                physics: const ClampingScrollPhysics(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

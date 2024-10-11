import 'package:app_image_search_toy/core/base_view.dart';
import 'package:app_image_search_toy/core/hive/hive_manager.dart';
import 'package:app_image_search_toy/core/hive/key.dart';
import 'package:app_image_search_toy/ui/component/error_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/photo_view.dart';

import 'image_detail_view_model.dart';

class ImageDetailView extends BaseView<ImageDetailViewModel> {
  const ImageDetailView({super.key});

  static const routerName = "/image_detail";

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget body(BuildContext ctx) {
    return Obx(() {
      final url = controller.url.value;

      return Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InkWell(
              onTap: clickImage,
              child: PhotoView(
                imageProvider: NetworkImage(url),
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const ErrorImage(color: Colors.white);
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box<String>(HiveBoxName.favorite).listenable(keys: [url]),
              builder: (context, box, widget) {
                final isFavorite = box.containsKey(url);
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: clickFavorite,
                      child: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.redAccent : Colors.grey,
                        size: 65,
                      ),
                    ),
                  ),
                );
              },
            ),
            Obx(() {
              return AnimatedOpacity(
                opacity: controller.isViewBack.value,
                duration: const Duration(milliseconds: 100),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: clickBack,
                    child: Container(
                      color: Colors.white.withOpacity(0.09),
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 5),
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.grey,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      );
    });
  }

  clickBack() {
    Get.back();
  }

  /// 백버튼 보이기 / 숨기기
  clickImage() {
    if (controller.isViewBack == 0.0) {
      controller.isViewBack.value = 1.0;
    } else {
      controller.isViewBack.value = 0.0;
    }
  }

  /// 즐겨찾기 추가 / 제거
  clickFavorite() async {
    final Box box;

    if (Hive.isBoxOpen(HiveBoxName.favorite)) {
      box = Hive.box<String>(HiveBoxName.favorite);
    } else {
      box = await HiveManager.openBox<String>(HiveBoxName.favorite);
    }

    final url = controller.url.value;

    if (box.containsKey(url)) {
      box.delete(url);
    } else {
      box.put(url, url);
    }
  }
}

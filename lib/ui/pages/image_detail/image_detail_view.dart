import 'package:app_image_search_toy/core/base_view.dart';
import 'package:app_image_search_toy/ui/component/error_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          InkWell(
            onTap: controller.clickImage,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(controller.imageDocument.imageUrl),
              heroAttributes: PhotoViewHeroAttributes(tag: controller.imageDocument),
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return const ErrorImage(color: Colors.white);
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.favoriteBox.listenable(keys: [controller.imageDocument.uniqueKey]),
            builder: (context, box, widget) {
              final isFavorite = box.containsKey(controller.imageDocument.uniqueKey);
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: controller.changeFavorite,
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
            return SizedBox(
              width: double.infinity,
              height: 50,
              child: AnimatedOpacity(
                opacity: controller.isViewBack.value,
                duration: const Duration(milliseconds: 100),
                child: InkWell(
                  onTap: controller.moveBack,
                  child: Container(
                    padding: const EdgeInsets.only(top: 9),
                    color: Colors.white.withOpacity(0.09),
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.grey,
                            size: 32,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            controller.imageDocument.displaySitename,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

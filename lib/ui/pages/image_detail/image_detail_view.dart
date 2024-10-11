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
        fit: StackFit.expand,
        children: [
          InkWell(
            onTap: controller.clickImage,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(controller.url),
              heroAttributes: PhotoViewHeroAttributes(tag: controller.url),
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return const ErrorImage(color: Colors.white);
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller.favoriteBox.listenable(keys: [controller.url]),
            builder: (context, box, widget) {
              final isFavorite = box.containsKey(controller.url);
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
            return AnimatedOpacity(
              opacity: controller.isViewBack.value,
              duration: const Duration(milliseconds: 100),
              child: Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  onTap: controller.moveBack,
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
    // return Obx(() {
    //   final url = controller.url.value;
    //   if (url.isEmpty) return const SizedBox();
    //
    //   return Container(
    //     color: Colors.black,
    //     child: Stack(
    //       fit: StackFit.expand,
    //       children: [
    //         InkWell(
    //           onTap: controller.clickImage,
    //           child: PhotoView(
    //             // imageProvider: NetworkImage(url),
    //             imageProvider: CachedNetworkImageProvider(url),
    //             heroAttributes: PhotoViewHeroAttributes(tag: url),
    //             errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
    //               return const ErrorImage(color: Colors.white);
    //             },
    //           ),
    //         ),
    //         ValueListenableBuilder(
    //           valueListenable: controller.favoriteBox.listenable(keys: [url]),
    //           builder: (context, box, widget) {
    //             final isFavorite = box.containsKey(url);
    //             return Padding(
    //               padding: const EdgeInsets.all(40.0),
    //               child: Align(
    //                 alignment: Alignment.bottomRight,
    //                 child: InkWell(
    //                   onTap: controller.changeFavorite,
    //                   child: Icon(
    //                     Icons.favorite,
    //                     color: isFavorite ? Colors.redAccent : Colors.grey,
    //                     size: 65,
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //         Obx(() {
    //           return AnimatedOpacity(
    //             opacity: controller.isViewBack.value,
    //             duration: const Duration(milliseconds: 100),
    //             child: Align(
    //               alignment: Alignment.topCenter,
    //               child: InkWell(
    //                 onTap: controller.moveBack,
    //                 child: Container(
    //                   color: Colors.white.withOpacity(0.09),
    //                   width: double.infinity,
    //                   padding: const EdgeInsets.only(left: 5),
    //                   height: 50,
    //                   alignment: Alignment.centerLeft,
    //                   child: const Icon(
    //                     Icons.arrow_back_ios_rounded,
    //                     color: Colors.grey,
    //                     size: 32,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         })
    //       ],
    //     ),
    //   );
    // });
  }
}

import 'package:app_image_search_toy/model/image_document.dart';

import 'package:app_image_search_toy/ui/component/error_image.dart';
import 'package:app_image_search_toy/ui/pages/main/main_view_model.dart';
import 'package:app_image_search_toy/util/log.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchImage extends StatelessWidget {
  final ImageDocument imageDocument;
  final MainViewModel controller;

  const SearchImage({super.key, required this.imageDocument, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.moveImageDetail(imageDocument),
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// 이미지
          Hero(
            tag: imageDocument,
            child: CachedNetworkImage(
              imageUrl: imageDocument.imageUrl,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    color: Colors.black12,
                  ),
                ),
              ),
              errorWidget: (context, url, error) {
                Log.e("error: $url $error");
                return const ErrorImage(color: Colors.black);
              },
              fadeOutDuration: Duration.zero,
              // fadeInDuration: const Duration(milliseconds: 300),
            ),
          ),

          /// 즐겨찾기 버튼
          ValueListenableBuilder(
            valueListenable: controller.favoriteBox.listenable(keys: [imageDocument.uniqueKey]),
            builder: (context, box, widget) {
              final isFavorite = box.containsKey(imageDocument.uniqueKey);

              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => controller.changeFavorite(imageDocument),
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
        ],
      ),
    );
  }
}

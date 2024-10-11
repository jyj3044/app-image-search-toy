import 'package:app_image_search_toy/core/hive/hive_manager.dart';
import 'package:app_image_search_toy/core/hive/key.dart';
import 'package:app_image_search_toy/ui/component/error_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchImage extends StatelessWidget {
  final String url;

  const SearchImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: url,
          child: Image.network(
            url,
            fit: BoxFit.fitHeight,
            scale: 1.0,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return const ErrorImage(color: Colors.black);
            },
            frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              } else {
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: child,
                );
              }
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
      ],
    );
  }

  /// 즐겨찾기 추가 / 제거
  clickFavorite() async {
    final Box box;

    if (Hive.isBoxOpen(HiveBoxName.favorite)) {
      box = Hive.box<String>(HiveBoxName.favorite);
    } else {
      box = await HiveManager.openBox<String>(HiveBoxName.favorite);
    }

    if (box.containsKey(url)) {
      box.delete(url);
    } else {
      box.put(url, url);
    }
  }
}

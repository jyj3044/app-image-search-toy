import 'package:app_image_search_toy/core/hive/key.dart';
import 'package:app_image_search_toy/data/model/Image_model.dart';
import 'package:app_image_search_toy/ui/component/error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchImage extends StatelessWidget {
  final ImageDocument imageDocument;

  const SearchImage({super.key, required this.imageDocument});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageDocument.imageUrl,
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
        ValueListenableBuilder(
          valueListenable: Hive.box(HiveBoxName.favorite).listenable(keys: [imageDocument.imageUrl]),
          builder: (context, box, widget) {
            final isFavorite = box.containsKey(imageDocument.imageUrl);
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: clickFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline_rounded,
                    color: Colors.red,
                    size: 60,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  clickFavorite() async {
    final Box box;

    if (Hive.isBoxOpen(HiveBoxName.favorite)) {
      box = Hive.box(HiveBoxName.favorite);
    } else {
      box = await Hive.openBox(HiveBoxName.favorite);
    }

    if (box.containsKey(imageDocument.imageUrl)) {
      box.delete(imageDocument.imageUrl);
    } else {
      box.put(imageDocument.imageUrl, DateTime.now().millisecondsSinceEpoch);
    }
  }
}

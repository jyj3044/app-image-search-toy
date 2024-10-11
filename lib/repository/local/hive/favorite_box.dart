import 'package:app_image_search_toy/core/hive/hive_manager.dart';
import 'package:app_image_search_toy/model/image_document.dart';

import 'package:app_image_search_toy/util/log.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class FavoriteBox {
  static const String name = "favorite";
  static const int typeId = 1;

  static Future<Box<ImageDocument>> open() async {
    return await HiveManager.openBox<ImageDocument>(name);
  }

  static Box<ImageDocument> box() {
    return Hive.box<ImageDocument>(name);
  }

  static Future<void> close() async {
    try {
      await Hive.box<ImageDocument>(name).close();
    } catch (e, s) {
      Log.e("hive close", error: e, stackTrace: s);
    }
  }
}

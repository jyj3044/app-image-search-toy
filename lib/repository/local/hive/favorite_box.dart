import 'package:app_image_search_toy/core/hive/hive_manager.dart';
import 'package:app_image_search_toy/util/log.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class FavoriteBox {
  static const String name = "favorite";

  static Future<Box<String>> open() async {
    return await HiveManager.openBox<String>(name);
  }

  static Box<String> box() {
    return Hive.box<String>(name);
  }

  static Future<void> close() async {
    try {
      await Hive.box<String>(name).close();
    } catch (e, s) {
      Log.e("hive close", error: e, stackTrace: s);
    }
  }
}

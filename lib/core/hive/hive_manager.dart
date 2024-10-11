import 'package:app_image_search_toy/core/hive/key.dart';
import 'package:app_image_search_toy/core/log.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveManager {
  static initHive() async {
    final futureTask = <Future>[];

    // 어댑터 초기화
    {
      // futureTask.add(_initAdapter(HiveObjectId.ORDER, HiveBoxName.ORDER, OrderAdapter()));

      await Future.wait(futureTask);
      futureTask.clear();
    }

    // Key Value 박스 오픈
    {
      futureTask.add(openBox<String>(HiveBoxName.favorite));

      await Future.wait(futureTask);
      futureTask.clear();
    }

    // 내부DB 박스 오픈
    {
      // futureTask.add(_openBox<Order>(HiveBoxName.ORDER));

      await Future.wait(futureTask);
    }
  }

  static Future<void> _initAdapter<T>(int hiveId, String hiveBoxName, TypeAdapter<T> adapter) async {
    try {
      if (!Hive.isAdapterRegistered(hiveId)) {
        Hive.registerAdapter(adapter);
      }
    } catch (e, s) {
      Log.e("Hive.registerAdapter(${adapter.toString()})", error: e, stackTrace: s);
      if (hiveBoxName.isNotEmpty) {
        await Hive.deleteBoxFromDisk(hiveBoxName);
        Hive.registerAdapter(adapter);
      }
    }
  }

  static Future<Box<T>> openBox<T>(String hiveBoxName) async {
    try {
      if (!Hive.isBoxOpen(hiveBoxName)) {
        return await Hive.openBox<T>(hiveBoxName);
      } else {
        return Hive.box<T>(hiveBoxName);
      }
    } catch (e, s) {
      Log.e("Hive.openBox($hiveBoxName)", error: e, stackTrace: s);
      await Hive.deleteBoxFromDisk(hiveBoxName);
      if (!Hive.isBoxOpen(hiveBoxName)) {
        return await Hive.openBox<T>(hiveBoxName);
      } else {
        return Hive.box<T>(hiveBoxName);
      }
    }
  }
}

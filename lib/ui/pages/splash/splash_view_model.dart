import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:app_image_search_toy/core/hive/hive_manager.dart';
import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:app_image_search_toy/util/log.dart';
import 'package:app_image_search_toy/ui/pages/main/main_view.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashViewModel extends BaseViewModel {
  @override
  void onReady() {
    super.onReady();

    _init();
  }

  _init() async {
    try {
      await Hive.initFlutter();
      await HiveManager.initHive();

    } catch (e, s) {
      Log.e("initHive", error: e, stackTrace: s);
    }

    Get.offNamed(MainView.routerName);
  }
}

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashViewModel());
  }
}

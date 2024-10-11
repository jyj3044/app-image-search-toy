import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:app_image_search_toy/model/image_document.dart';

import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:app_image_search_toy/ui/pages/image_detail/image_detail_view.dart';
import 'package:app_image_search_toy/ui/pages/main/tab_favorite_mixin.dart';
import 'package:app_image_search_toy/ui/pages/main/tab_search_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainViewModel extends BaseViewModel with GetTickerProviderStateMixin, TabSearchMixin, TabFavoriteMixin {
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();

    _init();
  }

  @override
  void onClose() {
    searchPageController.removeListener(nextPage);
    searchTextController.removeListener(searchTextListener);
    favoriteBox.listenable().removeListener(favoriteBoxListener);
  }

  /// 최초 초기화
  _init() async {
    isOnFavorite.value = favoriteBox.isNotEmpty;
    favoriteDataList.addAll(favoriteBox.values.toList());

    searchPageController.addListener(nextPage);
    searchTextController.addListener(searchTextListener);
    favoriteBox.listenable().addListener(favoriteBoxListener);
  }

  /// 즐겨찾기 변경
  void changeFavorite(ImageDocument imageDocument) async {
    if (favoriteBox.containsKey(imageDocument.uniqueKey)) {
      favoriteBox.delete(imageDocument.uniqueKey);
    } else {
      favoriteBox.put(imageDocument.uniqueKey, imageDocument);
    }
  }

  /// 이미지 상세로 이동
  void moveImageDetail(ImageDocument imageDocument) {
    try {
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      } else {
        Get.toNamed(ImageDetailView.routerName, arguments: imageDocument);
      }
    } catch (_) {}
  }

  /// 탭 버튼 클릭
  void onTap(int index) {
    try {
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      }
    } catch (_) {}

    if (!isOnFavorite.value) {
      tabController.index = 0;
      return;
    }

    tabController.index = index;
  }
}

class MainBindings extends Bindings {
  @override
  void dependencies() {
    FavoriteBox.open();
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}

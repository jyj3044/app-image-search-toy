import 'package:app_image_search_toy/model/image_document.dart';

import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';

mixin TabFavoriteMixin {
  final isOnFavorite = false.obs;

  final favoriteScrollController = PageController();
  final favoriteDataList = <ImageDocument>[].obs;
  final favoriteBox = FavoriteBox.box();

  /// 즐겨찾기 박스에 변화가 있을 때마다 호출
  void favoriteBoxListener() {
    isOnFavorite.value = favoriteBox.isNotEmpty;
    favoriteDataList.clear();
    favoriteDataList.addAll(favoriteBox.values.toList());
  }
}

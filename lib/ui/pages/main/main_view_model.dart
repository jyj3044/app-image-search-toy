import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:app_image_search_toy/repository/remote/search_image_repository.dart';
import 'package:app_image_search_toy/ui/pages/image_detail/image_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainViewModel extends BaseViewModel with GetTickerProviderStateMixin {
  late final TabController tabController;
  final isOnFavorite = false.obs;
  final scrollDirection = ScrollDirection.forward.obs;
  final searchFocusNode = FocusNode();

  // search
  final searchPageController = PageController();
  final searchTextController = TextEditingController();
  final realText = "".obs;
  final searchDataList = <String>[].obs;
  final searchText = "".obs;

  // favorite
  final favoriteScrollController = PageController();
  final favoriteDataList = <String>[].obs;
  final Box<String> favoriteBox = FavoriteBox.box();

  int searchPage = 1;
  int searchSize = 10;

  ValueChanged<int> get onTap {
    return (index) {
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
    };
  }

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
    favoriteBox.listenable().removeListener(favoriteBoxListener);
    searchPageController.removeListener(nextPage);
    searchTextController.removeListener(searchTextListener);
  }

  _init() async {
    // searchScrollController.listenScrollDirection(scrollDirection); // 스크롤 방향에 따라 상단 바를 숨김/보임 처리
    isOnFavorite.value = favoriteBox.isNotEmpty;
    favoriteDataList.addAll(favoriteBox.values.toList());
    searchPageController.addListener(nextPage);
    searchTextController.addListener(searchTextListener);
    favoriteBox.listenable().addListener(favoriteBoxListener);
  }

  /// 검색텍스트를 실시간으로 저장
  void searchTextListener() {
    realText.value = searchTextController.text;
  }

  /// 즐겨찾기 박스에 변화가 있을 때마다 호출
  void favoriteBoxListener() {
    isOnFavorite.value = favoriteBox.isNotEmpty;
    favoriteDataList.clear();
    favoriteDataList.addAll(favoriteBox.values.toList());
  }

  /// 최초 검색용
  void search() async {
    final string = searchTextController.text;
    if (string.isEmpty) {
      Fluttertoast.showToast(msg: "검색어를 입력해주세요.");
      return;
    }

    if (searchText.value == string) {
      Fluttertoast.showToast(msg: "검색어를 변경해쥇요");
      return;
    }

    if (searchFocusNode.hasFocus) {
      searchFocusNode.unfocus();
    }

    searchDataList.clear();
    searchPage = 1;
    searchText.value = searchTextController.text;

    final response = await SearchImageRepository.searchImage(searchText.value, page: searchPage);
    if (response.meta.totalCount == 0) {
      Fluttertoast.showToast(msg: "검색 결과가 없습니다.");
      return;
    }
    searchDataList.addAll(response.documents.map((e) => e.imageUrl).toList());
  }

  /// 페이징용
  void nextPage() async {
    if (searchDataList.length < searchPage * searchSize) return;

    if (searchPageController.page == searchDataList.length - 1) {
      final response = await SearchImageRepository.searchImage(searchText.value, page: ++searchPage);
      searchDataList.addAll(response.documents.map((e) => e.imageUrl).toList());
    }
  }

  /// 즐겨찾기 변경
  void changeFavorite(String url) async {
    final box = await FavoriteBox.open();

    if (box.containsKey(url)) {
      box.delete(url);
    } else {
      box.put(url, url);
    }
  }

  /// 이미지 상세로 이동
  void moveImageDetail(String url) {
    try {
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      } else {
        Get.toNamed(ImageDetailView.routerName, arguments: url);
      }
    } catch (_) {}
  }
}

class MainBindings extends Bindings {
  @override
  void dependencies() {
    FavoriteBox.open();
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}

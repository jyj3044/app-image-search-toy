import 'package:app_image_search_toy/model/image_document.dart';

import 'package:app_image_search_toy/repository/remote/search_image_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/get_rx.dart';

mixin TabSearchMixin {
  final searchPageController = PageController();
  final searchTextController = TextEditingController();
  final searchFocusNode = FocusNode();

  final realText = "".obs;
  final searchText = "".obs;
  final searchDataList = <ImageDocument>[].obs;

  int searchPage = 1;
  int searchSize = 10;

  /// 검색텍스트를 실시간으로 저장
  void searchTextListener() {
    realText.value = searchTextController.text;
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

    try {
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      }
    } catch (_) {}

    searchDataList.clear();
    searchPage = 1;
    searchText.value = searchTextController.text;

    final response = await SearchImageRepository.searchImage(searchText.value, page: searchPage);
    if (response.meta.totalCount == 0) {
      Fluttertoast.showToast(msg: "검색 결과가 없습니다.");
      return;
    }

    searchDataList.addAll(response.documents.toList());
  }

  /// 페이징용
  void nextPage() async {
    if (searchDataList.length < searchPage * searchSize) return;

    if (searchPageController.page == searchDataList.length - 1) {
      final response = await SearchImageRepository.searchImage(searchText.value, page: ++searchPage);
      searchDataList.addAll(response.documents.toList());
    }
  }
}

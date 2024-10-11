import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:app_image_search_toy/model/image_document.dart';
import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:get/get.dart';

class ImageDetailViewModel extends BaseViewModel {
  final favoriteBox = FavoriteBox.box();
  final imageDocument = Get.arguments as ImageDocument;
  final isViewBack = 1.0.obs;

  @override
  void onReady() {
    super.onReady();

    _init();
  }

  _init() async {}

  /// 백버튼 보이기 / 숨기기
  void clickImage() {
    if (isViewBack == 0.0) {
      isViewBack.value = 1.0;
    } else {
      isViewBack.value = 0.0;
    }
  }

  // 뒤로가기
  void moveBack() {
    Get.back();
  }

  /// 즐겨찾기 추가 / 제거
  void changeFavorite() async {
    final box = await FavoriteBox.open();

    if (box.containsKey(imageDocument.uniqueKey)) {
      box.delete(imageDocument.uniqueKey);
    } else {
      box.put(imageDocument.uniqueKey, imageDocument);
    }
  }
}

class ImageDetailBindings extends Bindings {
  @override
  void dependencies() {
    FavoriteBox.open();
    Get.lazyPut<ImageDetailViewModel>(() => ImageDetailViewModel());
  }
}

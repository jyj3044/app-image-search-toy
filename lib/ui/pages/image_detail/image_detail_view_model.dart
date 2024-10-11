import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:get/get.dart';

class ImageDetailViewModel extends BaseViewModel {
  final url = "".obs;
  final isViewBack = 1.0.obs;

  @override
  void onReady() {
    super.onReady();

    _init();
  }

  _init() async {
    url.value = Get.arguments;
  }
}

class ImageDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageDetailViewModel>(() => ImageDetailViewModel());
  }
}

import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:get/get.dart';

class SampleViewModel extends BaseViewModel {
  @override
  void onReady() {
    super.onReady();

    _init();
  }

  _init() async {}
}

class SampleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SampleViewModel>(() => SampleViewModel());
  }
}

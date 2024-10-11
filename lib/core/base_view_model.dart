import 'package:app_image_search_toy/constant/state.dart';
import 'package:get/get.dart';

abstract class BaseViewModel<T> extends GetxController {
  final pageState = PageState.IDLE.obs;
}
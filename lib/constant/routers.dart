import 'package:app_image_search_toy/ui/pages/image_detail/image_detail_view.dart';
import 'package:app_image_search_toy/ui/pages/image_detail/image_detail_view_model.dart';
import 'package:app_image_search_toy/ui/pages/main/main_view.dart';
import 'package:app_image_search_toy/ui/pages/main/main_view_model.dart';
import 'package:app_image_search_toy/ui/pages/splash/splash_view.dart';
import 'package:app_image_search_toy/ui/pages/splash/splash_view_model.dart';
import 'package:get/get.dart';

abstract class Routers {
  static const initialRoute = SplashView.routerName;
  static final routers = [
    GetPage(
      name: SplashView.routerName,
      page: () => const SplashView(),
      transition: Transition.cupertino,
      binding: SplashBindings(),
    ),
    GetPage(
      name: MainView.routerName,
      page: () => const MainView(),
      transition: Transition.cupertino,
      binding: MainBindings(),
    ),
    GetPage(
      name: ImageDetailView.routerName,
      page: () => const ImageDetailView(),
      transition: Transition.cupertino,
      binding: ImageDetailBindings(),
    ),
  ];
}

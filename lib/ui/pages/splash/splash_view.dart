import 'package:app_image_search_toy/core/base_view.dart';
import 'package:flutter/widgets.dart';

import 'splash_view_model.dart';

class SplashView extends BaseView<SplashViewModel> {
  const SplashView({super.key});

  static const routerName = "/";

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget body(BuildContext ctx) {
    return Container();
  }
}

import 'package:app_image_search_toy/core/base_view.dart';
import 'package:flutter/widgets.dart';

import '_view_model.dart';

class SampleView extends BaseView<SampleViewModel> {
  const SampleView({super.key});

  static const routerName = "/sample";

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => null;

  @override
  Widget body(BuildContext ctx) {
    return Container();
  }
}

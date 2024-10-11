import 'package:app_image_search_toy/core/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

abstract class BaseView<VM extends BaseViewModel> extends GetView<VM> {
  const BaseView({super.key});

  PreferredSizeWidget? appBar(BuildContext ctx);

  Widget body(BuildContext ctx);

  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext ctx) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(ctx),
        body: body(ctx),
        drawer: drawer(),
      ),
    );
  }

  Widget? drawer() => null;
}

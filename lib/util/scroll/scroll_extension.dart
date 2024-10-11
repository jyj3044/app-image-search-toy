import 'package:app_image_search_toy/core/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

extension ScrollExtension on ScrollController {
  void listenScrollDirection(Rx<ScrollDirection> scrollDirection) {
    addListener(() {
      try {
        if (scrollDirection.value == ScrollDirection.idle) return;

        if (scrollDirection.value != position.userScrollDirection) {
          scrollDirection.value = position.userScrollDirection;
        }
      } catch (e, s) {
        Log.e("scrollDirection.addListener", error: e, stackTrace: s);
      }
    });
  }
}

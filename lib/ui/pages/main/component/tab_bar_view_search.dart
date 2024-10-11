import 'package:app_image_search_toy/core/log.dart';
import 'package:app_image_search_toy/ui/pages/image_detail/image_detail_view.dart';
import 'package:app_image_search_toy/ui/pages/main/component/search_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main_view_model.dart';

class TabBarViewSearch extends StatelessWidget {
  final MainViewModel controller;

  const TabBarViewSearch({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            focusNode: controller.searchFocusNode,
            controller: controller.searchTextController,
            textInputAction: TextInputAction.search,
            onEditingComplete: controller.search,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: "Image Search",
              isDense: true,
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIconConstraints: const BoxConstraints(minWidth: 20, minHeight: 40),
              suffixIcon: SizedBox(
                width: 65,
                height: 40,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        return Visibility(
                          visible: controller.realText.isNotEmpty,
                          child: InkWell(
                            onTap: controller.searchTextController.clear,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.clear_outlined,
                                color: Colors.black45,
                                size: 25,
                              ),
                            ),
                          ),
                        );
                      }),
                      InkWell(
                        onTap: controller.search,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.search, color: Colors.black, size: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.all(10.0),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
            style: const TextStyle(color: Colors.black),
          ),
          const Divider(height: 1, color: Colors.black12),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Obx(() {
      final data = controller.searchDataList;
      if (data.isEmpty) return Container();

      return PageView.builder(
        controller: controller.searchPageController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final url = data[index];
          return InkWell(onTap: () => clickPageView(url), child: SearchImage(url: url));
        },
        physics: const ClampingScrollPhysics(),
      );
    });
  }

  /// 포커스 제거 & 이미지 상세 이동
  void clickPageView(String url) {
    try {
      if (controller.searchFocusNode.hasFocus) {
        controller.searchFocusNode.unfocus();
      } else {
        Get.toNamed(ImageDetailView.routerName, arguments: url);
      }
    } catch (_) {}
  }
}

import 'package:app_image_search_toy/core/base_view.dart';
import 'package:app_image_search_toy/ui/pages/main/component/tab_bar_view_favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'component/tab_bar_view_search.dart';
import 'main_view_model.dart';

class MainView extends BaseView<MainViewModel> {
  const MainView({super.key});

  static const routerName = "/main";

  @override
  PreferredSizeWidget? appBar(BuildContext ctx) => PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: Obx(() {
          return AnimatedCrossFade(
            firstChild: TabBar(
              indicatorWeight: 0.1,
              indicatorColor: Colors.transparent,
              labelColor: Colors.redAccent,
              dividerHeight: 0,
              controller: controller.tabController,
              tabs: const [
                Tab(
                  icon: Icon(Icons.search),
                  text: "Search",
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: "Favorite",
                )
              ],
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              onTap: controller.onTap,
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: controller.scrollDirection.value == ScrollDirection.forward ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 100),
          );
        }),
      );

  @override
  Widget body(BuildContext ctx) {
    return Container(
      color: CupertinoColors.systemGrey3,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                TabBarViewSearch(controller: controller),
                TabBarViewFavorite(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

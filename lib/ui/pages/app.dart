import 'package:app_image_search_toy/constant/color.dart';
import 'package:app_image_search_toy/constant/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Image Favorite Toy',
      initialRoute: Routers.initialRoute,
      getPages: Routers.routers,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(
          onSurface: AppColor.bgPrimary, // 앱 배경
          surfaceContainerHighest: AppColor.bgPrimary, // 앱 배경
          seedColor: AppColor.bgPrimary,
          brightness: Brightness.light, // 밝기
        ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              labelStyle: const TextStyle(color: Colors.black),
            ),
      ),
    );
  }
}

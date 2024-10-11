import 'package:app_image_search_toy/constant/color.dart';
import 'package:app_image_search_toy/constant/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
          seedColor: AppColor.bgPrimary,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

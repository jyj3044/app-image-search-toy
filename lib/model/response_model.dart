import 'package:app_image_search_toy/model/meta.dart';

abstract class ResponseModel<T> {
  ResponseModel({required this.meta, required this.documents});

  final Meta meta;

  final List<T> documents;
}
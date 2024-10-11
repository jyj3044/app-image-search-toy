import 'package:app_image_search_toy/model/image_document.dart';
import 'package:app_image_search_toy/model/meta.dart';
import 'package:app_image_search_toy/model/response_model.dart';

class ImageModel extends ResponseModel<ImageDocument> {
  ImageModel({required super.meta, required super.documents});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        meta: Meta.fromJson(json['meta']),
        documents: List<ImageDocument>.from(json['documents'].map((x) => ImageDocument.fromJson(x))),
      );

  @override
  String toString() {
    return 'meta: $meta, documents: $documents';
  }
}

import 'package:app_image_search_toy/data/model/meta.dart';
import 'package:app_image_search_toy/data/model/response_model.dart';

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

class ImageDocument {
  ImageDocument({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.displaySitename,
    required this.docUrl,
    required this.dateTime,
  });

  final String collection;
  final String thumbnailUrl;
  final String imageUrl;
  final int width;
  final int height;
  final String displaySitename;
  final String docUrl;
  final DateTime dateTime;

  factory ImageDocument.fromJson(Map<String, dynamic> json) => ImageDocument(
        collection: json['collection'],
        thumbnailUrl: json['thumbnail_url'],
        imageUrl: json['image_url'],
        width: json['width'],
        height: json['height'],
        displaySitename: json['display_sitename'],
        docUrl: json['doc_url'],
        dateTime: DateTime.parse(json['datetime']),
      );

  @override
  String toString() {
    return 'collection: $collection, thumbnailUrl: $thumbnailUrl, imageUrl: $imageUrl, width: $width, height: $height, displaySitename: $displaySitename, docUrl: $docUrl, dateTime: $dateTime';
  }
}

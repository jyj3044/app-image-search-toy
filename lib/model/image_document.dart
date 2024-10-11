import 'package:app_image_search_toy/repository/local/hive/favorite_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'image_document.g.dart';

@HiveType(typeId: FavoriteBox.typeId)
class ImageDocument extends HiveObject {
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

  get uniqueKey => imageUrl;

  @HiveField(0, defaultValue: "")
  final String collection;
  @HiveField(1, defaultValue: "")
  final String thumbnailUrl;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int width;
  @HiveField(4)
  final int height;
  @HiveField(5, defaultValue: "")
  final String displaySitename;
  @HiveField(6, defaultValue: "")
  final String docUrl;
  @HiveField(7)
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

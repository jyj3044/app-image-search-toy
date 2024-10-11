// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDocumentAdapter extends TypeAdapter<ImageDocument> {
  @override
  final int typeId = 1;

  @override
  ImageDocument read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageDocument(
      collection: fields[0] == null ? '' : fields[0] as String,
      thumbnailUrl: fields[1] == null ? '' : fields[1] as String,
      imageUrl: fields[2] as String,
      width: fields[3] as int,
      height: fields[4] as int,
      displaySitename: fields[5] == null ? '' : fields[5] as String,
      docUrl: fields[6] == null ? '' : fields[6] as String,
      dateTime: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ImageDocument obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.collection)
      ..writeByte(1)
      ..write(obj.thumbnailUrl)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.displaySitename)
      ..writeByte(6)
      ..write(obj.docUrl)
      ..writeByte(7)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

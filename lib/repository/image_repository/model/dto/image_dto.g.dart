// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      imageCacheUrl: json['imageCacheUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageCacheUrl': instance.imageCacheUrl,
      'id': instance.id,
    };

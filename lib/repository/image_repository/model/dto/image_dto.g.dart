// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppImage _$AppImageFromJson(Map<String, dynamic> json) => AppImage(
      imageCacheUrl: json['imageCacheUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$AppImageToJson(AppImage instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageCacheUrl': instance.imageCacheUrl,
      'id': instance.id,
    };

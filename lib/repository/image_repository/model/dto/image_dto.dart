import 'package:json_annotation/json_annotation.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class AppImage {

  AppImage({
    required this.imageCacheUrl,
    required this.imageUrl,
    required this.id
  });

  final String imageUrl;
  final String imageCacheUrl;
  final String id;

  factory AppImage.fromJson(Map<String,dynamic> json) =>
      _$AppImageFromJson(json);
  Map<String,dynamic> toJson() => _$AppImageToJson(this);
}
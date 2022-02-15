import 'package:json_annotation/json_annotation.dart';

part 'image_dto.g.dart';

@JsonSerializable()
class Image {

  Image({
    required this.imageCacheUrl,
    required this.imageUrl,
    required this.id
  });

  final String imageUrl;
  final String imageCacheUrl;
  final String id;

  factory Image.fromJson(Map<String,dynamic> json) =>
      _$ImageFromJson(json);
  Map<String,dynamic> toJson() => _$ImageToJson(this);
}
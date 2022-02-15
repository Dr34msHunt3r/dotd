import 'package:dotd/repository/image_repository/model/dto/image_dto.dart';

abstract class ImageSource {
  const ImageSource();

  Future<List<AppImage>> loadImages();
  Future<AppImage> addImage(AppImage image);
  Future<bool> deleteImage(AppImage image);
  Future<bool> updateImage(AppImage image);

  static const REST_API = "RESTAPI";
  static const MOOR = "MOOR";
  static const SECURE_STORAGE = "SECURE_STORAGE";
  static const RTDB = "RTDB";
}
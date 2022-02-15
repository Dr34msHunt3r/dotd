import 'package:dotd/repository/image_repository/model/dto/image_dto.dart';

import 'image_source.dart';

class ImageCloudStorageSource implements ImageSource {
  @override
  Future<AppImage> addImage(AppImage image) {
    // TODO: implement addImage
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteImage(AppImage image) {
    // TODO: implement deleteImage
    throw UnimplementedError();
  }

  @override
  Future<List<AppImage>> loadImages() {
    // TODO: implement loadImages
    throw UnimplementedError();
  }

  @override
  Future<bool> updateImage(AppImage image) {
    // TODO: implement updateImage
    throw UnimplementedError();
  }

}
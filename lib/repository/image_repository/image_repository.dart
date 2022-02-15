import 'package:dotd/database/cloud_storage/image_cloud_storage.dart';
import 'package:dotd/extensions/flavor_config.dart';
import 'package:dotd/repository/image_repository/model/dto/image_dto.dart';
import 'package:dotd/repository/image_repository/sources/image_cloud_storage_source.dart';
import 'package:dotd/repository/image_repository/sources/image_source.dart';

class ImageRepository {
  late final ImageSource _source;

  ImageRepository(){
    switch(FlavorConfig.instance.flavor.name){
      case ImageSource.REST_API:
        // _source = RecipeRestApiSource();
        break;
      case ImageSource.MOOR:
        // _source = RecipeMoorSource();
        break;
      case ImageSource.SECURE_STORAGE:
        // _source = RecipeSecureStorageSource();
        break;
      case ImageSource.RTDB:
        _source = ImageCloudStorageSource();
        break;
      // default: _source = RecipeMoorSource();
    }
  }

  Future<List<AppImage>> fetchImages() async {
    return await _source.loadImages();
  }

  Future<AppImage> addRecipe(AppImage image) async {
    return await _source.addImage(image);
  }

  Future<bool> deleteRecipe(AppImage image) async {
    return await _source.deleteImage(image);
  }

  Future<bool> updateRecipe(AppImage image) async {
    return await _source.updateImage(image);
  }
}
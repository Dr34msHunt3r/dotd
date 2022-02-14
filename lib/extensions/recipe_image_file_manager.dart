import 'dart:io';
import 'package:dotd/config/app_assets.dart';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

Future<String?> selectImageSource(ImageSource source, String? oldImage) async{
  try {
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null){
      return oldImage;
    }else{
      return newImage.path;
    }
  } catch (e) {
    throw Exception('Failed to pick image: ${e}');
  }
}

Future<File> saveNewImage(String imagePath) async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    File image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  } catch (e) {
    throw Exception('Failed to save new image: ${e}');
  }
}

Future<File> replaceImage(String imagePath, File? image) async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(image!.path);
    image = File('${directory.path}/${name}');
    return File(imagePath).copy(image.path);
  } catch (e) {
    throw Exception('Failed to replace image: ${e}');
  }
}

Future<String> setImageUrl(String path, String oldImageUrl) async{
  try {
    if(path != oldImageUrl && oldImageUrl != AppAssets.defaultRecipeImage){
      imageCache!.clearLiveImages();
      imageCache!.clear();
      return (await replaceImage(path, File(oldImageUrl))).path;
    }else if(oldImageUrl == AppAssets.defaultRecipeImage){
      imageCache!.clearLiveImages();
      imageCache!.clear();
      return (await saveNewImage(path)).path;
    }else{
      throw Exception('Failed to preset image: Image was null');
    }
  } catch (e) {
    throw Exception('Failed to preset image: ${e}');
  }
}

Future<Recipe> setRecipeImage(Recipe recipe)async{
  final String? imageUrl;
  if(recipe.imageCacheUrl!=null && recipe.imageUrl != recipe.imageCacheUrl) {
    imageUrl =
        await setImageUrl(recipe.imageCacheUrl!, recipe.imageUrl);
  }else{
    imageUrl = null;
  }
  return Recipe(
      recipeRecipe: recipe.recipeRecipe,
      ingredients: recipe.ingredients,
      recipeTitle: recipe.recipeTitle,
      imageUrl: imageUrl ?? recipe.imageUrl,
      favourite: recipe.favourite,
      id: recipe.id
  );
}

bool deleteRecipeImage(Recipe recipe){
  try {
    if(recipe.imageUrl != AppAssets.defaultRecipeImage) {
      File(recipe.imageUrl).delete();
    }
    return true;
  } on Exception catch (e) {
    throw Exception('Failed to delete recipe image: ${e}');
  }
}


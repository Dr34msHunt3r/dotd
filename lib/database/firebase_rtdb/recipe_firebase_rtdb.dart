import 'package:dotd/config/app_errors_messages.dart';
import 'package:dotd/database/cloud_storage/image_cloud_storage.dart';
import 'package:dotd/extensions/recipe_rtbd_converter.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:firebase_database/firebase_database.dart';

class RecipeRealtimeDatabase {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference _refRecipe = FirebaseDatabase.instance.ref('recipes');

  ImageCloudStorage _imageCloudStorage = ImageCloudStorage();
  AppErrorMessages _appErrorMessages = AppErrorMessages();


  Future<Recipe> addRecipe(Recipe recipe) async{
    try {
      final key = await _refRecipe.push();
      String? imageUrl = null;
      if(recipe.imageCacheUrl != null)
      {
         imageUrl = await _imageCloudStorage.uploadFile(recipe.imageCacheUrl!, key.key as String);
      }
      key.set(recipeToRTDB(recipe, key.key as String, imageUrl));
      await _refRecipe.child(key.key as String).child('ingredients').set(ingredientsToRTDB(recipe.ingredients));
      return await Recipe(
          favourite: recipe.favourite,
          imageUrl: imageUrl ?? recipe.imageUrl,
          ingredients: recipe.ingredients,
          recipeTitle: recipe.recipeTitle,
          recipeRecipe: recipe.recipeRecipe,
          id: key.key
      );
    } on Exception catch (e) {
      return _appErrorMessages.addingRecipeError(e);
    }
  }

  Future<bool> deleteRecipe(Recipe recipe) async{
    try {
      await _imageCloudStorage.deleteFile(recipe.imageUrl);
      await _refRecipe.child("${recipe.id}").remove();
      return true;
    } on Exception catch (e) {
      return _appErrorMessages.deletingRecipeError(e);
    }
  }

  Future<List<Recipe>> loadRecipes() async{
    try {
      final stream = await _refRecipe.once();
      final List<Recipe> _recipeList = [];

      stream.snapshot.children.forEach((event) {
        _recipeList.add(recipeFromRTDB(event.value as dynamic, []));
      });
      return _recipeList;
    } on Exception catch (e) {
      return _appErrorMessages.loadingRecipesError(e);
    }
  }

  Future<Recipe> updateRecipe(Recipe updatedRecipe) async{
    try {
      String? imageUrl = null;
      if(updatedRecipe.imageCacheUrl != null && updatedRecipe.imageUrl != updatedRecipe.imageCacheUrl)
      {
        imageUrl = await _imageCloudStorage.uploadFile(updatedRecipe.imageCacheUrl!, updatedRecipe.id!);
      }
      _refRecipe.child("${updatedRecipe.id}").set(recipeToRTDB(updatedRecipe, updatedRecipe.id, imageUrl));
      return Recipe(
          recipeRecipe: updatedRecipe.recipeRecipe,
          ingredients: updatedRecipe.ingredients,
          recipeTitle: updatedRecipe.recipeTitle,
          imageUrl: imageUrl ?? updatedRecipe.imageUrl,
          favourite: updatedRecipe.favourite,
          id: updatedRecipe.id
      );
    } on Exception catch (e) {
      return _appErrorMessages.updatingRecipeError(e);
    }
  }

}
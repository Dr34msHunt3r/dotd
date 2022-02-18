import 'dart:convert';
import 'package:dotd/config/app_errors_messages.dart';
import 'package:dotd/database/secure_storage/recipe_secure_storage.dart';
import 'package:dotd/extensions/recipe_image_file_manager.dart';
import 'package:dotd/repository/recipe_repository/model/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/sources/recipe_source.dart';

class RecipeSecureStorageSource implements RecipeSource {

  final RecipeSecureStorage _recipeSecureStorage = RecipeSecureStorage();
  final AppErrorMessages _appErrorMessages = AppErrorMessages();

  @override
  Future<List<Recipe>> loadRecipes() async{
    return await _recipeSecureStorage.readAll();
  }

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    return await _recipeSecureStorage.writeRecipe(await setRecipeImage(recipe));
  }

  @override
  Future<bool> deleteRecipe(Recipe recipe) async{
    return deleteRecipeImage(recipe)
    && await _recipeSecureStorage.deleteRecipe(recipe.id!);
  }

  @override
  Future<Recipe> updateRecipe(Recipe updatedRecipe) async{
    try {
      final Recipe recipe = await setRecipeImage(updatedRecipe);
      await _recipeSecureStorage.editRecipe(
          jsonEncode(recipe.toJson()),
          updatedRecipe.id!
      );
      return recipe;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

}
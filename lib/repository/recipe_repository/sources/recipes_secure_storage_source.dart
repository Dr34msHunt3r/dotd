import 'dart:convert';
import 'package:dotd/database/custom_rest_api/services/dto/recipe_dto.dart';
import 'package:dotd/database/secure_storage/recipe_secure_storage.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';

class RecipeSecureStorageSource implements Source {

  final RecipeSecureStorage _recipeSecureStorage = RecipeSecureStorage();

  @override
  Future<List<Recipe>> loadRecipes() async{
    return await _recipeSecureStorage.readAll();
  }

  @override
  Future<Recipe> addRecipe(Recipe recipe) async{
    return await _recipeSecureStorage.writeRecipe(recipe);
  }

  @override
  Future<bool> deleteRecipe(Recipe recipe) async{
    return await _recipeSecureStorage.deleteRecipe(recipe.id!);
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    return await _recipeSecureStorage.editRecipe(
        jsonEncode(updatedRecipe.toJson()),
        updatedRecipe.id!
    );
  }

}
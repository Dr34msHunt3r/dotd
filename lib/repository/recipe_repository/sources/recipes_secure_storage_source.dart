import 'dart:convert';

import 'package:dotd/api/services/dto/recipe_dto.dart';
import 'package:dotd/repository/recipe_repository/sources/source.dart';
import 'package:dotd/secure_storage/recipe_secure_storage.dart';

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
  Future<bool> deleteRecipe(String recipesId) async{
    return await _recipeSecureStorage.deleteRecipe(recipesId);
  }

  @override
  Future<bool> updateRecipe(Recipe updatedRecipe) async{
    return await _recipeSecureStorage.editRecipe(
        jsonEncode(updatedRecipe.toJson()),
        updatedRecipe.id!
    );
  }

}
import 'dart:convert';

import 'package:dotd/data/models/recipe_model/recipe_model.dart';
import 'package:dotd/data/network_services/recipe_secure_storage/recipe_secure_storage.dart';
import 'package:dotd/data/repositories/recipe_repository/sources/source.dart';

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